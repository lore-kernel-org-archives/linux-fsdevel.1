Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17487390C86
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776238122; cv=pass; b=Y+FRIo2GMGOOwgkijuckUguySk5lolDbBjG6BsT86zuGtqUcQ1F5K4qfqRkxe+hnoGCxEeoOxyuK1zjrkKL2seLNSSqGw8lwsmPzv9/76KRNyjZDcUZ/dNj2AVl8XjVns+z6RFA7kcLfCZn+rSbjx/erTRFXc3/7DTcZHG7S8MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776238122; c=relaxed/simple;
	bh=VCfsoF/dvBd9Qdbxqp9+TU/8lR+ChdTpMMQTLjzh8zA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Org4EQ9mNHkv0dHDFZRghe2rOMv/+U1oYIR92Cle0rBENqCR7U2FnzAYUFTMDIcqvR5NxeNgcsNaMBacBBEhAzZVBU1OZsddP309UuhwAdhno0o22foFAp+d3ofDY7iaO0qUsL4HyFL3KjSyR8o+5ony5s54k4v7g9NHFSBhnu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=WNAzP8yk; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="WNAzP8yk"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c19d23b19so7553335c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 00:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776238120; cv=none;
        d=google.com; s=arc-20240605;
        b=XIPKENbc/onP+BoC7rhDWCpy3DdqwFKkL6EOlAZlCSUgSDoYO7yDH9o77bEfahVGe7
         cDyXI5Rb3Z9VPCDaR6oxxk/l5ViJN7aDHwrTKaZoHlBrGpWRnpqwfXeQZBUZHY1lh/pf
         ohlsdf3jKWqxQ4im+di/CeJcr14ZZwgGDkvjMpxMRCf5KBWsDcBI3SohoqLpPhtp4vxs
         98Jo4dH96cxd9OfsrbbUJG9H6pHIIe1BO1e+T0IE+ER1en7eLdPbpdon77Tq6U4g9bE0
         A1by6V825mE0OgFkLZ0y9QsZLNDexRMBFol7jxQq3uzajrtwAKBN7Mafe3SX0sBuQYKK
         78/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=i3RCg8jAq8bEKU8zr1VoGVX0lX4zwfP6AXnb54K8yLQ=;
        fh=3BGh9CD4hh89kISSNHGGP3Y9dD1rcUmTOhuzBvQtGrY=;
        b=J2/0qls3DI0Gr+C6xdveVQAQHeg/BjeyrJEmVEnYbVX2HqABUgtq0g29w3A1IjfYwQ
         drxQjAh7iSegkaIwkDnX0YLH2P+opz0JZhzJ9dls8ttMgaVwnZKX/euAOf/ugaudPPDz
         kmorqO6SsYjhE7Jb8IyLvZ8I7nJlAD5+z2u92k967uPUGK/zIr+72/cFoI0elDAmo1PZ
         NMzhTflmb3yDDUEgXIzD9yMre1cChdT4z0utqVzELOBEfALN6U6uIr7xtm/6Xh3Ge3yq
         v/npvdg939z17lfEh7SSULQct5GPLwGwKVYdxlqlBeAGNVREbuRg2hZ6z0fVywG/x1hU
         Gs0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1776238120; x=1776842920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i3RCg8jAq8bEKU8zr1VoGVX0lX4zwfP6AXnb54K8yLQ=;
        b=WNAzP8ykZXxxBmcc3ColjxChZ87Ropp781oXCtWZjDr1T4l5tQdGYD9MXIS7O/W68v
         WeYhKwMe7dRlL88xFM07D9x5kdrW+Lhzuz+KkofyYlpYXS1FSz7wgdvRQeyBz9ysCaXu
         BX3HCcj93aqun4nH0wJfHxeBfH6kejPoyYiLngqMGekFm8mMyNSuNrxSc9Q8HNpn1Psb
         1HZF3e36txHPupQhIZDZn7020vll0O21jIwvEcU4pzjZFxjKPu3pMglK+hIMMQqmxkib
         0VSkGXGJvySV+C04VXaeCcf277idcRXgnZqeormku5y9YdC++tO3qirrIXBpsGa81ZdX
         nuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776238120; x=1776842920;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3RCg8jAq8bEKU8zr1VoGVX0lX4zwfP6AXnb54K8yLQ=;
        b=idusuVd+/JRBbFmIuhO9/Z7vcjgLa9bnbM+0jMYyShkZ4EgcxeIaTBf/tvTwGO+t+0
         fUA2FSmMn+unLwP/GrwmLqQc+xv/1tYMVz177Le+FnrQxDjIRdjth39npsXZNFq71aYq
         etg6bm+DTk0hv1zsaj+5Rp4KLRIVQjsQeIxJrQ7ovpW6LpcMg7BpJbbyEnIqK+Rar8gL
         DA2SuWUAt1Mcbo+sRgHtYceYY5bQfrQaBVx1QZBUp6lkAjqWioRXZOXunHPQggiYiM79
         AKjdDqQUkLOKgivFYANchWKw/M/YKw/ZmvPLtlq0OPfmzd+FeoozhkrPn9cPwjQy0QP3
         Kf3A==
X-Forwarded-Encrypted: i=1; AFNElJ89uzhpMaNBmzhoU3dpoMuT0SOH8M2X1lnE8cUxCT/oXnz8qIJNWS7wrxyGIcECfGO/HhJZ0mk8L7uUCHZk@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGvzrM62acPE48lguDVdIS6XnVx53IPIUrv5YYyMmR7syihC/
	N6VL94sGPTqWq45fe2/MX8SxQ2piosuOodkxCL0krTuLJ1zeYBql183Y3+tRVkCHfAIRhumKLlT
	xJw+w+z3jmDTFR07zhgXiAiqCG8sgxI/OrYvznknFhg==
X-Gm-Gg: AeBDievGz6394xMpdHf0FR984htLEf/9xmgzcotMN1LREpd87wZ20PBGynbeJbSn5s3
	maftEAoF8WD8zS4eFwai586UQW+bDBacszDbo0mjRuc2K3vN+ixXlxcbRA8YMP3DynMLpEMhsr8
	PRUAe/hJntezHUSkJJMUYzqj9V9oefL6xwx2e3nKm4SCWii4ODsmaaQ5lnsrbb5O39qQyb/rQY1
	yH+j9B5r6mz0uGzLF3+FAuE+cXoj2VgVIYt4SZEo0KgTqCwvH7pCta3Zi3Rf4eqB3ToJjb0Xm3E
	V0s3WqhfaZERLG8Kmw==
X-Received: by 2002:a05:7022:3d12:b0:128:ceac:6da6 with SMTP id
 a92af1059eb24-12c34ee91c9mr11364895c88.30.1776238120061; Wed, 15 Apr 2026
 00:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mingyu He <mingyu.he@shopee.com>
Date: Wed, 15 Apr 2026 15:28:27 +0800
X-Gm-Features: AQROBzAm2xFwr4MALc1zssK1xrKh48KJqi6cFMhuCqu4uq6NyXdJo7D0QDgCiSQ
Message-ID: <CAAoBcuSK38z5Nh7rGuHDFwpNvtc0W49OZKc1_d1QkCbK_nL7Ew@mail.gmail.com>
Subject: [ISSUE] Read performance regression when using RWF_DONTCACHE form
 8026e49 "mm/filemap: add read support for RWF_DONTCACHE"
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org, 
	willy@infradead.org, kirill@shutemov.name, bfoster@redhat.com, 
	Jens Axboe <axboe@kernel.dk>, littleswimmingwhale@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Introduction:

I found this feature quite useful because in many scenarios, files
only need to be read once and then discarded. Keeping them in the page
cache can lead to a drop in read performance during cache reclaim.
Therefore, I conducted functional tests after the official release of
v7.0.0. I found that in normal preadv2 read scenarios (write has not
been tested yet), the read performance actually has a significant
regression. I would like to discuss whether this is expected, or if my
usage or application scenario is incorrect.

Test Project:

I tested reading a 5GB file on my NVMe drive using preadv2. The file
was generated using:

dd if=/dev/random of=file_top.bin oflag=direct bs=1M count=5120

The test was conducted in two scenarios:

Running outside of any cgroup.

Running within a cgroup with limits: memory.max = 3G, memory.high = 1G.

Each scenario ran the test program once. The test program performs a
controlled experiment: the first round uses preadv2 with
RWF_DONTCACHE, and the second round does not.

Test Results:

I found that after applying RWF_DONTCACHE, the performance dropped
quite drastically. This result was consistent both inside and outside
the cgroup. During the tests, I monitored memory.stat within the
cgroup and confirmed that RWF_DONTCACHE was indeed working (the file
cache remained very small).

The smaller the buffer_size in the test program, the more the
performance dropped. Initially, I used a 4k buffer_size, and the
performance decreased significantly. When the buffer_size was
increased to 128K, the read performance with RWF_DONTCACHE actually
surpassed the non-flagged version by about 10%.

Important:

I suspect this is due to readahead. In most cases, files that are
"accessed once" are read sequentially. RWF_DONTCACHE might be dropping
these readahead pages, resulting in a failure to fully utilize data
locality. In contrast, reads without the flag do not drop these
prefetch pages, making them much faster.

Discussion:

Is there an issue with my program? Or is the test flawed? If both are
fine, is it worth further optimizing RWF_DONTCACHE in this regard? The
concept of RWF_DONTCACHE itself is very attractive, but the practical
effect in this scenario is not ideal.

Below is my test program and hardware information:

================================

CPU: Intel(R) Xeon(R) Gold 5220R CPU @ 2.20GHz (96 cores)

OS: Ubuntu 24.04

Kernel: v7.0.0 (Tested after official release)

Disk:

nvme0n1 ext4 1.7T 5G 0% 0 Dell Ent NVMe v2 AGN RI U.2 1.92TB /data


=================================

Test Results (with 4k buffer_size):

File: /data/file_top.bin (5.00 GiB)

=== Round 1: preadv2 + RWF_DONTCACHE ===

file: /data/file_top.bin

flags: RWF_DONTCACHE

page cache dropped

bytes read: 5368709120 (5.00 GiB)

time: 35068.1 ms

throughput: 146.0 MiB/s

=== Round 2: preadv2 (normal) ===

file: /data/file_top.bin

flags: (none)

page cache dropped

bytes read: 5368709120 (5.00 GiB)

time: 3428.6 ms

throughput: 1493.3 MiB/s


==============================

Test Program:

/*

test_preadv2_dontcache.c - Compare preadv2 with/without RWF_DONTCACHE

*/

#define _GNU_SOURCE

#include <stdio.h>

#include <stdlib.h>

#include <string.h>

#include <fcntl.h>

#include <unistd.h>

#include <errno.h>

#include <sys/uio.h>

#include <sys/stat.h>

#include <time.h>

#ifndef RWF_DONTCACHE

#define RWF_DONTCACHE 0x00000080

#endif

#define BUF_SIZE (4 * 1024)

#define DEFAULT_PATH "/data/file_top.bin"

static void drop_caches(void)

{

int fd;

sync();

fd = open("/proc/sys/vm/drop_caches", O_WRONLY);

if (fd < 0) exit(1);

write(fd, "3\n", 2);

close(fd);

}

static double time_diff_ms(struct timespec *start, struct timespec *end)

{

return (end->tv_sec - start->tv_sec) * 1000.0 +

(end->tv_nsec - start->tv_nsec) / 1e6;

}

static void read_file(const char *path, int flags, const char *label)

{

char *buf;

struct iovec iov;

struct timespec t_start, t_end;

ssize_t ret;

off_t offset = 0;

size_t total = 0;

int fd;

    buf = aligned_alloc(4096, BUF_SIZE);
    fd = open(path, O_RDONLY);
    iov.iov_base = buf;
    iov.iov_len = BUF_SIZE;

    drop_caches();
    clock_gettime(CLOCK_MONOTONIC, &t_start);

    while (1) {
            ret = preadv2(fd, &iov, 1, offset, flags);
            if (ret <= 0) break;
            offset += ret;
            total += ret;
    }

    clock_gettime(CLOCK_MONOTONIC, &t_end);
    printf("\n=== %s ===\n", label);
    printf("  throughput: %.1f MiB/s\n",
           total / (1024.0 * 1024.0) /
           (time_diff_ms(&t_start, &t_end) / 1000.0));

    close(fd);
    free(buf);

}

int main(int argc, char *argv[])

{

const char *path = DEFAULT_PATH;

if (argc > 1) path = argv[1];

read_file(path, RWF_DONTCACHE, "Round 1: preadv2 + RWF_DONTCACHE");

read_file(path, 0, "Round 2: preadv2 (normal)");

return 0;

}

________________________________
