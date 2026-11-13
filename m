Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551114;
	b=Ty5X9KB22wddiOEk+UzNDzJ1Ee5OuNhwMQcBIrYOBm8ARbLYdqmPS0y/RZxga1F2WmaW
	 p+ECRjROVZd3ILH4J7kxYxH6wjnwgX1y5iTfaS+jWQ6mZKpqONpK7iNgb7G6DwYejBMTf
	 yV6Jx4XfbmMqGZFWn9nwQ3hz6Ayaqcc2QcIVkv3oTL0EEANLrJxWwXFcT/wG6sVyefpv9
	 2PEbJIifuTV9C8YBagfpA77yw9KFd6jJCNIPTPMehZZM+LqSrkZ9JFRXBAyshWzkOZ8eI
	 Bxw539H5t61jX+E6bb9LBGA7w8Y7c9GlHRupPdbmC2fW+k6r0jdtlc38/R7k0LcNCwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3tlK4/UTFCYCg7fMWH6nOmeYXoGJRxWoGIF/cCb+vIs=;
	b=PPr/WxWpKaoVpGpRUlC68re2qQANA18LEJmcp1l/uG/BHceUVh3zA80lUQkFiaE1S7yz
	 MUx9Cey6FR8z+NCGccJ0fxnjT88MOxzOuGSZsADVjEBEy/26JdqlrDTjma1bfP9MKeWGP
	 O87c6GdOwlzYSO3s/FukEipefMVQoPF1Nxq0f8SzpGHRrcakT1/6IGnxRkjxNgCDJUm7a
	 ecJUWYwiOZeDe1QTWEWN0NLp82AtlumTpj51hiGpHV0wffgfpePXUfQ4tUAUfN//rOvoH
	 vKkthtetAyPH9jMNdJODOgdsBu1/yrr8a5lyfAI7cNlps9E0EF/3G4nlv+3qHdXoLlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRYD88H8;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41301606A32D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 06:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41301606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRYD88H8
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36dbde64409so1010966eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 22:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794551113; x=1795155913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3tlK4/UTFCYCg7fMWH6nOmeYXoGJRxWoGIF/cCb+vIs=;
        b=xRYD88H8XzFlGeLpT5BYFxdyuFcpl3eKTy3hjqp7XNkaNZDdgqCOpoiyBh9tuHTD1q
         DzxiCyMbKAnrEVO4vKlvGgHmjI2rWsOPx2+EKG83b/MGOzZGuqK5bjNBWMBy+NXecmdC
         lmmFXS+VBHRAxsZo4sOA53rf1090wrLleee+knPMcd57rcwkBtxqQk+/aSD/MReq1Peu
         ViTjXyDK3NuwCfU/2AxAjGfB9+GpKCzLcA+ztjfC1n4SeS3MvURf95kTksCaLiV6/bJ7
         ImqDIqRFKtpTVX8C+jCbfn3hijO7N4zxPwNnsoHueQUEYmhom3zQcUkzRz8a1n086w5+
         m5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551113; x=1795155913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3tlK4/UTFCYCg7fMWH6nOmeYXoGJRxWoGIF/cCb+vIs=;
        b=Y9ufZn/8v7MZR/y5y7lcX0N8xoAKDyZMbedZrKyhmSsoNwcFaw/ZQeTLFSteeA17wo
         CHfFkklpx/ZTIsxFVP44uCOlIHwu8sQicWMM462gKGGTR1q5NqvNwKAeY5+AgwkW2eup
         8vRt6SGIXvYH6FduPNYyC83WyDYZeIH4sbL95bVoBL4avUY810ijBZo8Bh4YdYKDOrUh
         MCVDhysv2bUtTED+VoNBIRJeg3QCL3NJkKAb31lZbZMvlIyrklZbxXnIm3BZ0EGI+gDl
         i+uN9BDFmR6imLBfHdSOLkwX5ignJwmplNClGcdeiXaIRi6v15z6cc0UIcFRC4rwYJZ4
         2HPw==
X-Forwarded-Encrypted: i=1; AL+hErGxGVDwXvdjwO1EEvFe9niqxMV8DWQAfQ0sFniRa46J2sbl47hm/4zZ/Sl6s0WSn9uYA/pC3p0qRLLwDOOx@vger.kernel.org
X-Gm-Message-State: APuU4Z+lt8xvSL0fI+AF+6mvMlF8o3dGfpJOljSctyrW60tBIDMuZexN
	goAihL3Zcp7AHimFMtVutGxXkmR5I3lzxkGpCvzBvWHgazaqsBuHMKZ7
X-Gm-Gg: AYBFou2eHC60NiFvXsiaZjfMDBTkDdfbmPjCCOyjKG6Oj+JU5MAQbN1bN2809ortIWI
	98xly7fqzVFvDrhTLZbUPLB0pwhKqPVgnmsAQ9U8N8L6LZoLaN92H2coH0cJC6FQ/YuXgenOUzL
	vIFEy/8YyzH5JInEMf1XXxhJgCOqjMRiZ+tmpy7pHjS2BUm0/umc+NtBXClKi9Ve/bYXmfkd2y/
	hhlIC9vRc6hKIcV6XxuCXhxCW4sjN9c02qVXPnOyZDaAp8WS8PEH5alPZPB1Kb0kAJerXBsQMDr
	y9RIdcR/cFFbvCASv+iUOD7tloytg1J7OIzO5Q7FLbSRb3wl68MpXAnOq2Hl0kHG91E8W7KVoAL
	b+aZGUsPFp3QYwaYEu7ODQ8Sa/iir5eB36I1Ilzxj2IwVqFtlmLv9MS73AzF1fw0aVrXHpEnSCF
	hhp8yEvKiJ4GoZEWEqUYVQk+OcP6Vbr5UW9ecNB7E+gy1W3WuTkDA46ijoOLuB9LEU7oPGTMRAm
	DQAo0oaHHo6kHFVeaCsuAZYqO53PDNDhAVuzUEkpTMx+6xbouxYG+JmANiilt8CBgxbKVMDsJ2c
	Hil5B7rSrAJX3jEOah6RRPiAzN1vfMEH/TR6bHC0FshOBeRd7/D9btyIUapY2WLvYqo=
X-Received: by 2002:a05:693c:894f:20b0:36d:5102:9974 with SMTP id 5a478bee46e88-379636607famr1340509eec.2.1794551112863;
        Thu, 12 Nov 2026 22:25:12 -0800 (PST)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([47.11.114.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795533170csm4309715eec.7.2026.11.12.22.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:25:12 -0800 (PST)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: alireza.haddadi@it.uu.se
Cc: jack@suse.cz,
	willy@infradead.org,
	akpm@linux-foundation.org,
	vishal.moola@gmail.com,
	fujunjie1@qq.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	tracekotae@gmail.com
Subject: Re: [PATCH] mm/filemap: let sequential faults restart mmap readahead
Date: Fri, 13 Nov 2026 06:24:46 +0000
Message-ID: <20261113062446.193820-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <26E03EC6-F37C-4350-B2A9-1F354217F469@it.uu.se>
References: <20261109-mmap-miss-v1-1-8b44b33f3358@it.uu.se> <20261111042310.191979-1-gopalmalaviya53@gmail.com> <26E03EC6-F37C-4350-B2A9-1F354217F469@it.uu.se>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 11, 2026 at 07:43:54AM +0000, Alireza Haddadi wrote:
> That would be great, thank you. Could you share the short-run test,
> So I can run the same here while working on it?

Sure, it is below. It writes the file (or reuses it with "keep"),
drops it from the page cache with POSIX_FADV_DONTNEED, touches 1% of
its pages through a MAP_PRIVATE mapping and prints the MiB read
(pgpgin in /proc/vmstat) and the major faults for each pattern:

  ./mmap-rand FILE               2600 MiB file, removed at the end
  ./mmap-rand FILE 20480 keep    20 GiB file, kept for the next run

The tables came from the second form in a 3 GiB guest, with
"echo 128 > /sys/block/vda/queue/read_ahead_kb" (or 8192) before each
run. "random 4-page recs" is the short-run case. Like the earlier
tests, the program was written with the help of an AI assistant.

Thanks,
Gopal

---8<--- mmap-rand.c
/*
 * mmap-rand.c: how much does the kernel read from disk for sparse
 * mmap access (random, and fixed stride) on a cold file?
 * Reports disk input (pgpgin from /proc/vmstat) and major faults.
 *
 *   ./mmap-rand FILE        (FILE must not exist; removed at the end)
 *   ./mmap-rand FILE SIZE_MIB keep   (reuse FILE if it exists, keep it)
 */
#define _GNU_SOURCE
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <unistd.h>

#define MIB	(1UL << 20)
static unsigned long SIZE = 2600 * MIB;

static long pgpgin_kib(void)
{
	char name[64];
	long val;
	FILE *f = fopen("/proc/vmstat", "r");

	if (!f)
		err(1, "/proc/vmstat");
	while (fscanf(f, "%63s %ld", name, &val) == 2)
		if (!strcmp(name, "pgpgin")) {
			fclose(f);
			return val;
		}
	errx(1, "no pgpgin");
}

static long majflt(void)
{
	struct rusage ru;

	getrusage(RUSAGE_SELF, &ru);
	return ru.ru_majflt;
}

static void run(const char *path, const char *name, unsigned long stride,
		unsigned long rec)
{
	unsigned long page = sysconf(_SC_PAGESIZE), npages = SIZE / page;
	unsigned long n = npages / 100, i, idx;	/* touch 1% of the pages */
	long in0, mf0;
	volatile char sink;
	char *m;
	int fd;

	fd = open(path, O_RDONLY);
	if (fd < 0)
		err(1, "open");
	if (posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED))
		errx(1, "posix_fadvise");
	m = mmap(NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
	if (m == MAP_FAILED)
		err(1, "mmap");

	srandom(1);
	in0 = pgpgin_kib();
	mf0 = majflt();
	for (i = 0; i < n; i += rec) {
		unsigned long j;

		idx = stride ? (i * stride) % npages : random() % (npages - rec);
		for (j = 0; j < rec; j++)	/* a record of rec adjacent pages */
			sink = m[(idx + j) * page];
	}
	printf("%-20s %6lu touches %8ld MiB read %6ld major faults\n", name, n,
	       (pgpgin_kib() - in0) / 1024, majflt() - mf0);

	(void)sink;
	munmap(m, SIZE);
	close(fd);
}

int main(int argc, char **argv)
{
	static char buf[MIB];
	unsigned long i;
	int fd;

	if (argc != 2 && argc != 4)
		errx(2, "usage: %s FILE [SIZE_MIB keep]", argv[0]);
	if (argc == 4)
		SIZE = strtoul(argv[2], NULL, 0) * MIB;
	fd = open(argv[1], O_WRONLY | O_CREAT | O_EXCL, 0600);
	if (fd >= 0) {
		memset(buf, 0x5a, sizeof(buf));
		for (i = 0; i < SIZE / MIB; i++)
			if (write(fd, buf, MIB) != (ssize_t)MIB)
				err(1, "write");
		if (fsync(fd))
			err(1, "fsync");
		close(fd);
	} else if (argc != 4) {
		err(1, "create");
	}

	setvbuf(stdout, NULL, _IOLBF, 0);
	run(argv[1], "random", 0, 1);
	run(argv[1], "stride 2053 pages", 2053, 1);
	run(argv[1], "random 2-page recs", 0, 2);
	run(argv[1], "random 4-page recs", 0, 4);
	if (argc != 4)
		unlink(argv[1]);
	return 0;
}
