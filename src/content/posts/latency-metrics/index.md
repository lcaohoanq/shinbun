---
title: "Understanding P50, P95, and P99 Latency Metrics"
published: 2026-07-24
description: "A practical guide to understanding percentile-based latency metrics and why average response times can be misleading."
image: "./image.png"
tags: ["performance", "observability", "devops", "monitoring", "backend"]
category: "Engineering"
draft: false
lang: en
---
# Understanding P50, P95, and P99 Latency Metrics

If you have worked with monitoring tools such as Prometheus, Grafana, Datadog, or New Relic, you have probably encountered metrics like **P50**, **P95**, and **P99**.

These metrics are commonly used to measure **latency**, helping engineers understand how quickly a system responds to requests. While average response time is easy to understand, it often hides performance problems that affect real users.

In this article, we'll explore what these metrics mean, why they matter, and how they are used in production systems.

## The Problem with Averages

Imagine an API receives 100 requests.

Most requests complete in around 100–200 ms, but a few requests take several seconds due to database locks, network issues, or resource contention.

Suppose the response times look like this:

```text
100ms
120ms
130ms
140ms
...
180ms
200ms
250ms
5000ms
```

The average latency might still be relatively low.

An engineer looking only at the average could conclude:

> "The system is performing well."

However, users who experience the 5-second delay would likely disagree.

This is where percentile metrics become valuable.

## What Is a Percentile?

A percentile indicates the value below which a certain percentage of observations fall.

For example:

- P50 means 50% of requests are faster than this value.
- P95 means 95% of requests are faster than this value.
- P99 means 99% of requests are faster than this value.

Percentiles help us understand not only the typical user experience but also the experience of users affected by slower requests.

---

## P50: The Median User Experience

P50 is the **50th percentile**, also known as the **median**.

Suppose:

```text
P50 = 120ms
```

This means:

> 50% of requests completed in 120 ms or less.

P50 represents the experience of a typical user and is useful for understanding general system responsiveness.

However, it does not tell us much about performance spikes or slow requests.

### Example

| Metric | Value |
| ------ | ----- |
| P50    | 120ms |

Interpretation:

- Half of all users experience response times below 120 ms.
- The other half experience response times above 120 ms.

---

## P95: The Experience of Most Users

P95 is the **95th percentile**.

Suppose:

```text
P95 = 500ms
```

This means:

> 95% of requests completed in 500 ms or less.

Only 5% of requests were slower than 500 ms.

P95 is often considered one of the most important latency metrics because it captures the experience of the vast majority of users while still exposing performance issues.

### Example

| Metric | Value |
| ------ | ----- |
| P95    | 500ms |

Interpretation:

- Most users experience response times under 500 ms.
- A small percentage of users may still encounter slow requests.

Many Service Level Objectives (SLOs) are defined using P95.

For example:

> 95% of API requests must complete within 500 ms.

---

## P99: Tail Latency

P99 is the **99th percentile**.

Suppose:

```text
P99 = 3000ms
```

This means:

> 99% of requests completed within 3 seconds.

Only 1% of requests were slower.

Although that sounds insignificant, systems processing millions of requests per day can generate thousands of slow user experiences.

P99 is often referred to as **tail latency** because it measures the slowest portion of the latency distribution.

### Example

| Metric | Value  |
| ------ | ------ |
| P99    | 3000ms |

Interpretation:

- Nearly all requests complete quickly.
- A small number of users experience severe delays.

Tail latency is frequently caused by:

- Database locks
- Slow queries
- Garbage collection pauses
- Network congestion
- External service timeouts
- Resource contention

---

## A Real-World Example

Consider a login service with the following metrics:

| Metric  | Value  |
| ------- | ------ |
| Average | 200ms  |
| P50     | 150ms  |
| P95     | 800ms  |
| P99     | 5000ms |

At first glance:

```text
Average = 200ms
```

The service appears healthy.

However:

- A typical user experiences around 150 ms latency.
- Most users experience less than 800 ms latency.
- Some users wait up to 5 seconds.

This illustrates why averages can be misleading.

Averages smooth out outliers, while percentiles reveal them.

## Visualizing Percentiles

Think of 100 users standing in a line from fastest response time to slowest.

```text
|----50%----|----------------45%----------------|----4%----|--1%--|
     P50                     P95                  P99
```

- P50 marks the middle user.
- P95 marks the user at position 95.
- P99 marks the user at position 99.

Everything beyond P99 represents the slowest requests in the system.

---

## Percentiles in Prometheus and Grafana

When using Prometheus, percentile calculations are commonly derived from histograms.

For example:

```promql
histogram_quantile(0.50, ...)
histogram_quantile(0.95, ...)
histogram_quantile(0.99, ...)
```

These correspond to:

```text
0.50 → P50
0.95 → P95
0.99 → P99
```

Grafana dashboards often display these metrics together to provide a complete view of system performance.

---

## Which Metric Should You Monitor?

Different percentiles serve different purposes.

| Metric | Purpose                                       |
| ------ | --------------------------------------------- |
| P50    | Typical user experience                       |
| P95    | Experience of most users                      |
| P99    | Tail latency and performance outliers         |
| P99.9  | Extreme latency analysis for critical systems |

As systems scale, engineers typically pay more attention to P95 and P99 than to averages.

These metrics reveal the hidden performance issues that users actually notice.

---

## Key Takeaways

- **P50** shows the experience of a typical user.
- **P95** shows the experience of almost all users.
- **P99** reveals tail latency and performance outliers.
- Average latency can hide serious problems.
- Monitoring P95 and P99 helps identify bottlenecks before they impact users at scale.

A simple way to remember them is:

> **P50:** What a normal user experiences
> **P95:** What a slightly unlucky user experiences
> **P99:** What the unluckiest users experience

In modern distributed systems, understanding tail latency is often more valuable than knowing the average response time. The users who encounter slow requests are usually the ones opening support tickets, leaving negative feedback, or abandoning your application altogether.
