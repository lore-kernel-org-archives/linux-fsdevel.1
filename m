Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601241;
	b=u5Y6KyxkG5JOA2+OW1qP4EoGd6MIywB5ww+T+6Kdi6Gjy8vgjhb1FLO5xDWRDr1C8eF4
	 EMbosIrj9KcRURfCuQQMy5wmcjFfqyaHxoIAfvgigC5CCjC+5GgSSrarJGKCPovU++ZkN
	 nMI99VSUR8cF07ZH7XeGBfHuK0/fe90Vv9hj0Y94BJRZ+ljss2NXDbwG9tvQQp4zdTQyv
	 Q+ZOstf/Kd8rxLYK8cy6+mIaFK7ZD8Sf0rjrU2JHXrdPFVKXGIZvoxpXE3JFrZVQi03mU
	 lk9WJjKimmC6yc7SjJsM7rfvH54gn859ehxCd8mKzYLLqmax3X1uK6BBSnFS6/gfG0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=PpQrV3M75vRIpsbPYF6CDFPX8mxlW9t3FWzswyav9Hw=;
	b=nK5xkQI6ztE+UMXzfyW/cvg4NCyJLq/0UcTDqMmJhEQ3pAwrzwf9uMcxMGEUh3+2Ko00
	 5FOlbyO4MWj7zt71DTIshCRq2durs25H+Ip76VRWj5SiEp5VMIqlStBt/COH9bKK6DwQ+
	 cMa956e/Y5jItBDrXAL50FCEMdxrkOeytaikr4LuJBie+zPTaqpEznMVg7JTm91K6xw+d
	 PspwNyXoGZLfB/flSRXzSUz3w5p1WMrjDRlq//BzkyDsts7k0JD8LEj4ZQR4a9iMK6lcH
	 JOCderYWQ4/tFoewoqfjayetMZcVVxHZ3z1xnTRHW2ehL5s3o5Hai96d6wMEgzV0gWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=AYx2MVsE;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE95606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 16:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE95606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=AYx2MVsE
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f1ca4132bso93864885a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792601240; x=1793206040; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PpQrV3M75vRIpsbPYF6CDFPX8mxlW9t3FWzswyav9Hw=;
        b=AYx2MVsEh9qn4oCcn+W2RaEHXX4/smyiVa0wet41zN2cdCN99EBGIabOrxKA7hSA/5
         VGmWS3/bhWN6UgbVwtLbN4UKxSYW006aHt00WD6cB13aANST2Zmh2kYf1hkgCqyN0ump
         Exe18KZ8csWenZAtZIE3sAchegzWVmjBVqtxZZ6zToJmy9HfTpSoNC275mR/6/e9SE9Y
         mIBqATCW1iZIgRau9U6PlvynyWE6ORfGFKpWP+FST13RgK6SMc3J8z4UWD5NiPgENt9O
         5jd4s/PTtU+OKySFVwy5IG3HGsuROKh0uTRA+O5ecrKoIIZ5Ta9JIM5nAptyhLhTEqx5
         WKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601240; x=1793206040;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PpQrV3M75vRIpsbPYF6CDFPX8mxlW9t3FWzswyav9Hw=;
        b=jgJS+h05IWly16kWbxzt/wMq7l/E1E5azEkyy+OMkWSvI4ebL+C2NHkpDRjbLte3vi
         8JmJ6ni0QUe3Mdick2HDT7mCaswn5NkYhF7ccT01bfMOHcqfYjkAtW688bIdBsZYNOgG
         n6WpH6vKWNJxXsLJ2TNaK4OeQ48Aw+K/PkjPbGNjFn2MOQBYvDdPQNT2cCzTEflZg12s
         /zwDeZy6aVEg2pcop9hZ2AxqVv7Ltx94cKbwProWKryRjDIodFyKrWpRFyJ08TGjUMv8
         QLB/1dDZNhKWba++SCZFMcHtLzVAiqGYlGdK1XuG7PCw7uO5d8IgF50Jwl4BYJUf0ed2
         Y5xg==
X-Gm-Message-State: AFq9FYKZRiz2ti99iDHCQsSgJWqerH3I8ntwK6XfK/NQAIBn0G9jpI01
	+17fyU0l5lGJBA1qwawucZIcPibEF11PmHbiI3eHFYYjPG140QWGh1y9NopVAJkP+P8=
X-Gm-Gg: AYBFou3y2HAFf1+HorsjDRmgtbZAJNnGi8m03a3EWrKQJ1JZMe4IX8XSoH3Ig33p45f
	EI89M2rcPXt7V1XaFxDoGaaq9So8pEblficjjr+29Nh8rHpWTGQJy0ExyD/E1G9uxpuWujVJ31h
	7SkKIQTiAWqzZZuj02KhEiYnKEvLxLuiuooQRkFbc2BlV9rORhAiVV+xJc75x/yh8+qJjj0TBEs
	bf0CNr9FDnpF9pOsTBgTPx6zx/sTNPKSAy1Y72pGyvAsuMLV1Cr86gQ8RHeZiJHopwuYLbM0UH2
	923JPujdT7g4oI2YypBcUuwhj06o4n0I+siQKRIjzGi2Ifareh8I1q++NZp30l+13ba+u32fvEP
	lihTe4bnolSqJnd1xoISlmNEUOij24EuHu5yE0e8dvRdfbLvf/YFXwnfvxFGabCP4gwL4lZLdHP
	gyDjPwkV7xjGswIpRkLjdWFdtlMzcP7zf0xJZ4BIsVSDeFnkbDzdQEOGocvutwl8zBNkX9To6L3
	eNax3C5ibJS568N7V7LUOkE2BQAdMIagcGn8ajHImlPB+iS6RswKmjZhwUKY50uAFswyB7J
X-Received: by 2002:a05:620a:1a04:b0:93e:5cf8:e5a4 with SMTP id af79cd13be357-93f57f4bd48mr519682685a.58.1792601239600;
        Wed, 21 Oct 2026 09:47:19 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56de57e8sm298585185a.25.2026.10.21.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:47:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/5] fs: don't let a stuck mount take everybody else with
 it
Date: Wed, 21 Oct 2026 16:46:56 +0000
Message-Id: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHs2GoC/2XMQQ7CIBCF4as0s3ZioYSKV2lcAI4WNdAwYkya3
 l3QpctvMu9fgSkHYjh2K2R6BQ4pVohdB3628UoYztUge6lFLwU6hVwWyvhI/o4lupQjjoMZtBn
 VQRkNdbpkuoT3NzudfubibuSfrdU+nGVCl230czs17v+6sG0f6+PwsqEAAAA=
X-Change-ID: 20261021-b4-super-lock-unborn-739369748496
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792601235; l=2988;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Mx6rWSe3d/zke3tB+djYDVv1P3RSX1m2KKj6LL9ZFS4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCJgiYVmhIVrdKsE6sgihLKqrt7bPKUKWGTkFSZFBvwqN8o5jUlgDtT49Urz5o+Id4oCaVC+jRp
 HnmWz5oLIpAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

This is the follow up to the stuck unmount series, and it applies on top
of it (vfs-7.5.super).

The same thing happens at the other end of a super block's life. We put
the super block on the lists in sget_fc(), but it isn't usable until
vfs_get_tree() sets SB_BORN, and super_lock() waits for that
uninterruptibly. If the mount is stuck reading from a dead device or
waiting on a server that went away, everything that walks the super
blocks backs up behind it, and there's no way to kill those things.

This isn't quite the mirror image of the unmount case. A dying super
block is going away, so skipping it loses nothing. An unborn one is
about to be in use, so anybody who has to get at every super block still
has to wait for it.

The things that only flush, sync(), drop_caches and Q_SYNC, skip it.
Nobody can have written to a file system that isn't mounted yet.

The things that are after that particular super block, a second mount of
the same device, ustat(), quotactl() and BLKFLSBUF, still wait for it,
but they can be killed now.

Everything else is left alone. SELinux in particular has to wait, NFS
sets up its security options before SB_BORN, and without a policy loaded
that gets deferred to the walk in selinux_complete_init(). The freeze,
thaw, emergency remount and device removal paths are unchanged as well.

For testing I put ext4 on a dm-linear device, dropped all the caches,
suspended the device underneath it and mounted, which leaves the mount
sitting in ext4_fill_super().  Without the series drop_caches,
quotactl(Q_SYNC), sync, ustat(), BLKFLSBUF and a second mount of the
device all end up in super_lock() and ignore SIGKILL, and the emergency
sync doesn't finish.  With it the first three come straight back and the
emergency sync completes, the other three wait but go away on SIGKILL.
Freezing the device waits for the mount with and without the series,
SIGKILL or not.  On both kernels the mount finishes once the device is
resumed, the data is there and nothing is left frozen, and 200 rounds of
mounting with sync, drop_caches, ustat() and Q_SYNC running against it
are fine.  This was with KASAN and lockdep on, neither had anything to
say.

fstests on ext4, xfs and btrfs gives the same results with and without
the series. Thanks,

Josef

---
Josef Bacik (5):
      fs: make a mount waiting on another mount killable
      fs: make ustat() and quotactl() killable in lookup
      fs: make BLKFLSBUF's wait for a superblock killable
      fs: don't make sync(2) wait for unborn superblocks
      fs: skip unborn superblocks in drop_caches and Q_SYNC

 fs/drop_caches.c |   2 +-
 fs/internal.h    |   1 +
 fs/quota/quota.c |   2 +-
 fs/super.c       | 168 +++++++++++++++++++++++++++++++++++++++++--------------
 4 files changed, 129 insertions(+), 44 deletions(-)
---
base-commit: b4b5957dcf76c676f8a21b24588667731e97bbbc
change-id: 20261021-b4-super-lock-unborn-739369748496

