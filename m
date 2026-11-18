Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001570;
	b=GOq+e/BZcHM0ObhxDzEc4lxQWgpWZ3bX6PIU+esWVoBiamfeFSc3FROUgFmJoo5vwSOD
	 Y+TNLz83G9SrY4JqvCb3CGEE8a22mWmmq1MA6V+pGufpbk2J7g5SD53uRYW+OIR0eq7ns
	 PF6VU7voZFU5l2y1xLLbAwTvdjTyQGXv8eFddkjM5aUpqceDKWZseABiOtg2lhh4ZOF87
	 2F+I4ByrMJwYQjbeQNBoccVm+jYQLFljdAIvkbIRzxhGzDkTcVmMoBDW3WoZs2VlrauHh
	 CWhAv8MQD2+2nlJ1n5MfphuqgywffQF86RwqVoGlcbb65X/AHUxWiopTNgij8cfH5wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xJFWv1xrhjfAyje7Ep/W9xVonaRZ/xPzzJA7Dg8c3lE=;
	b=wQJsShbe0/fvR6wXRDVOGNg05kXQ83Oe92v14NZS9HxxDeLGHyOalNnkA5I3eRtu825g
	 AWI9beSedf7y7yP19tqqVJaY/Ul2fgftRP9BvDiRgnVch9Hol/2J+gsGOe0MmHac+lMpf
	 oXS5EYWWqTjsfHrTw7gpwFcormJ7NYN8U46kpUavXMNZqpQOCWhK9nLkuXGenQjktQMlA
	 BP20PDLpkctqlPPwbdDSYD1G59LU8jRVsI/KH9I1AiHbJWUp1SkSflz2nMqS+2t7ctCjR
	 u+ONfQagZhz66V22UzzTNgpMHYB8VYyHbPVk79rTSxBg0P1yZwv0lNMI+OLjjBB6eCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVi+u3hB;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B31F606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 11:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B31F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVi+u3hB
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9eb579c0eso5228695ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 03:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001569; x=1795606369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJFWv1xrhjfAyje7Ep/W9xVonaRZ/xPzzJA7Dg8c3lE=;
        b=BVi+u3hBS8dmV4u9QmaPMl1y+DR9rFtlTWYFFhFMTGJk6YSKkhFcCYaOePrmrwKt8n
         wsLM9x9UZQeTIyihcuyM3Gu+4AMULhr2PUPcKQH/XAb9T+9AZib/0iKSzwu3aKmTKXh8
         Y0CrkPMSDwNt+XNX/OxWL/DkS5hBvQYzUkyBnmCxHpTLI9CpzwyKJ4CQuzI54WtyUAE/
         sj7Ao/DZoG9fU4LdXu42zOtGoocxmgvUjDTks2sX6ZpKvY5in4Ady39WiKx2zOkBDEm1
         LfT0qoIAeWgk0Dv3bpmofp65fsWHDEwzPZSceX7BlLa5ELRSIrzZy9jg0nFirLGgKRL+
         HKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001569; x=1795606369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJFWv1xrhjfAyje7Ep/W9xVonaRZ/xPzzJA7Dg8c3lE=;
        b=uqZcMX3/0MwCGC3EByCaQSnKmx7kM0UZSFHP0SR387NnzCjp15MFSXIzuMaFHpE6nj
         K40cZGzvS5aNg9YEMcrhuxcN+/iFzs10afdywmcd/W6CnPbL/UpoJxHHAVSx5db4C3aa
         bO2qjQ1DbUEYEi/U4tETgWeV82yIV5uJhYoAjVj7/Ri9fiSGEoDGCXvVrgmeYmy9l02V
         Cuoyi88uAdI4XbzIHKUqc8B4j68zRAQwVr7fZ3JoxjE9DuXBz2P7+VrlAOxnajkNmELb
         Q4w4oa+wTezYKAN+eqvBQ12nR3sS48KPxJuvGpT+vquPsFJimlGXRN8qWt+DbZ5Yc2Dx
         NBOA==
X-Forwarded-Encrypted: i=1; AL+hErHYCUbcilf6VLVLxo8F6vbt4Csob1dzgY87oyoFS3gc71rhp+Afs2Mhy+KfmTmUEUI+qcv6Owiz+M+yEgjn@vger.kernel.org
X-Gm-Message-State: APuU4Z/0U36mbvTftkeoL5d7xDC1JT8EsybavHESioRy1msywimwlwt6
	UphFNr1y15OzqpBd/xDLohdsItvioqJIw3CsKstYrCHtqoWGftuAjB6t
X-Gm-Gg: AZFdTZfj9m3K+uFrIdh8N+O5c8e2OJKuktHj7g/IVooEMJ+u40cfB1CbuGYpWjruolD
	hP+hRLwR/WqHoKRxyuX5ktBRt4pJ7v1iGuvgQgvyg4IqanNlkphlZBP5vQZaOapXeVzBXo9ylru
	a5FzdqbgLNep1VBOdSUhMoWpGpG6o8aBgiiVfz8UWhOPGoS0/6aBbDKpqcy7wDujyp5af6WIZTD
	LXnVoCf2+vu3p4h2kMjuBkuKy4mgXiQQ4HrP+BW/507FYi77UJSQVyDKigjFhcGwz0xDeQwOY5B
	mskmwBVwc5SqCS706CNnZwBkRdlpMp9OU+j/qGVZqTwQ2nVPhn0vBEFug6L8et/65dZy8SK8zUa
	E2HPz0Xm2VQIlhse0cCi5e/GlQ4ia8qL8lAa8coiv457YWiZY4/WVaD59gqgTscOOI/YUIEf7qh
	Kp65tRJVmFiCMSf5CM5erxhkAmTgdEFaUGLejKuUnqvTKn7CvoLgpBevJR5DeBJquLI32kQB2Ff
	x0uleJvK7RN+kg28T+Hys/y5fZswT83FhYiPR+pb9tv/FoiWoQZRa4SLau9MCrLQNAgxwj72iTS
	ROJ8XB/1kDoVljYUwgGbuliz7qERZnOG7ahLk6kBbjCrmNXX6Vx4jqc/a0dFrO1wkWttwWA=
X-Received: by 2002:a17:902:c94b:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2eff753c6b7mr21302625ad.54.1795001569415;
        Wed, 18 Nov 2026 03:32:49 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62930a5sm11612305ad.66.2026.11.18.03.32.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 03:32:49 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: amir73il@gmail.com
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Josef Bacik <josef@toxicpanda.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Ding Feng <dingf3ng@gmail.com>
Subject: Re: ovl: sync_file_range() does nothing on overlayfs files
Date: Wed, 18 Nov 2026 19:32:41 +0800
Message-ID: <20261118113241.29101-1-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAOQ4uxg5baphOjo+_A=3nZBmFEmMV7KOiv_W=rjEVYV41eTEaA@mail.gmail.com>
References: <CAOQ4uxg5baphOjo+_A=3nZBmFEmMV7KOiv_W=rjEVYV41eTEaA@mail.gmail.com>
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

Amir Goldstein wrote:
> Like this?
>
> Completely untested.

Thanks, Amir. I tested it on v7.4-rc3 (20eef29b7c84), where it applies
with an 8-line offset in mm/filemap.c.

Setup: arm64 defconfig in QEMU; overlayfs with lower and upper on one
ext4 disk; periodic writeback off (dirty_writeback_centisecs=0). Each
case writes 64 MiB (16384 pages) through the overlay and calls
sync_file_range(fd, 0, 0, flags). Dirty pages are read with cachestat()
on the upper file's ext4 path, before and after the call.

                                   before patch       with patch
  ext4 file, flags=7              16384 -> 0         16384 -> 0
  overlay new file, flags=7       16384 -> 16384     16384 -> 0
  overlay new file, flags=2       16384 -> 16384     16384 -> 0 (4096 under writeback)
  read-only fd opened before
  copy-up, written via another
  fd, flags=7                     16384 -> 16384     16384 -> 0

cachestat() on the overlay fd reported cache=0 dirty=0 before the patch
and cache=16384 dirty=16384 with it, in all three overlay cases. All
calls returned 0, and the kernel log showed no warnings.

Tested-by: Ding Feng <dingf3ng@gmail.com>

Two questions:

1. FUSE passthrough also keeps data in a backing file
(fs/fuse/passthrough.c) and already forwards ->fadvise(). Does it need
->f_real() too? I have not tested that.

2. In the copy-up case, sync_file_range() on a read-only fd can now
open the upper file and return that open's error. The man page lists
none of those codes. I assume that is acceptable, as a write would see
the same error, but I wanted to mention it.

Thanks,
Ding Feng
