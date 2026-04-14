Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7553E51E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168459; cv=none; b=DTglee8ga9w2dbfKlwB2lYo7C6uHoz9eBy/sVodYzHvVGMG9qS4vted4hy+DFBucNPYwAW7iIgRSKs2n3MAqQSMW4a+4eTyJBXLlgdQSZJn5aPUV1nKaST1O4AaQpLvm+FRy7sxBijFZEXXLeF0wuJnt0qD0Rw4DCHK50QeuBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168459; c=relaxed/simple;
	bh=C6PN2tv8TTYw6PZQNyyZ1Rg0SBPfgun9AXWA+SN5QCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8WziFPcbIEitLq4bugjDqvY0orTF+UfqbaK6m/L3ylC5Y6isHYXTNqalN3n9U+Ct50Y8PojsxoMaTRCPZ0g56YeFg5wzx1rnZZAV1UKyA24sM59+ScqolHBVJ6qkaB55nSf1QGzxXueyN4ekImDEEHxrWyx+1YAi50zjBUF8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488debfa07bso3100755e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 05:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168457; x=1776773257;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBVJRk9QryBisCG3/cC6tCqtgsY3R5164ZRYnE8QXr4=;
        b=rDUp7Qztw/ow0OI4zcx1F1oMXM8D0C4F4xAsBf+sKndR5+n9gkbpFcepGQxmKH4eWF
         H8fM9/pNhbGOB1TO9TX7Yz2PyoKR2K/SX1Lj9GopNhtl36r7OQrCtjDWTKYqOUGl9KRa
         QUzYFNGKdb52PYnt0QT4sB2zH6LZqU3kSUCIekA+vu4cIs0euUNmGMfunmgLbjA7NhFZ
         ffFmtINZ1uJ7HMozku4aA2ciYd7yNhgjtDVlEPooUwao+HrVyy2+MYqFPeLkvesWT2tw
         Qjz1rH+rnFXK+bqAQ6CVGMgSacBQkudMO6f+su1vq7T1wXyyYfvJzOnEifLLrJYkMLVj
         2qcQ==
X-Gm-Message-State: AOJu0YxNAMllSVaVu63GRayqu0ltBFiBNKG8bxV782tCaTwnWHbBvFm4
	n2IsKmbxjeHOelqJfdpCe4bnNiKpQQ2lfLneXuXDcxF3psFrvuJhM35KgN++GYGb
X-Gm-Gg: AeBDievcVn2sRufgCLTN6LOzsLXSWvWjhPkNDr97cB6mwkCWa3imC/kHOUfmTUa5hFj
	CwBT0vrpscv6c+QLiA0CwAu/rjJkGjAQiZuMM2PQoeL7uASHHPa74XsxbKL6E6NltR7L90lCGaA
	bucdinPOB+5l8CYIGsAdNTqEZ2IRb3uL3OEp7KhwsDtlsqwo/xtWs1f2LK+WjeTWZoGYMB3FhYF
	9KFcKjvlzAKhnQf7IKOGh5ZoMqFAGM4ygi4EOJoS8YDl1biKmKpW4nzSlXdp5pV+e1Agt+cX2GA
	hIvximWFMDfKboGki/eptXoEu0J2OeyLLhhUFfGznPTjMz+olg715OtW8k68DUUf5ZOxedse7hc
	bnj5+YpmfYYIQNG8YmiKUsg5SiglJMtSXi0gNJs7Z8UTxsmuRsJwPZUNP3MFwQ+43NSGjFhJ2aB
	xwEk53FinqDIXj83Ba0/x16qxp/UtWRMC1aQPqizDwzAVI1V1wqegqk4v3I8P2kC2A0z0nsOC8G
	2H2ohb/s0zmc3qi
X-Received: by 2002:a05:600c:3149:b0:487:575:5e3 with SMTP id 5b1f17b1804b1-488d68c7001mr110552565e9.5.1776168456905;
        Tue, 14 Apr 2026 05:07:36 -0700 (PDT)
Received: from hackers.camp ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee03898bsm45341275e9.11.2026.04.14.05.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:07:36 -0700 (PDT)
Received: (nullmailer pid 8795 invoked by uid 1000);
	Tue, 14 Apr 2026 13:30:36 -0000
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: Pedro Falcato <pfalcato@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust Filesystem
In-Reply-To: <fkf75lk2sm2nfych34jiyoeqfctwkirzo22coqsad72yeau7ht@mh36h7nercwh>
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <fkf75lk2sm2nfych34jiyoeqfctwkirzo22coqsad72yeau7ht@mh36h7nercwh>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 15:30:36 +0200
Message-Id: <1776173436.199615.8794.nullmailer@me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Mon, Apr 13, 2026 at 03:04:11PM +0000, Pedro Falcato wrote:
> Well, here's the obvious question: do you have a usecase for this?

The target is embedded Linux systems in radiation-intensive environments
where single-event upsets (SEU) cause silent bit flips in data at rest.
Specifically: nanosatellites using MRAM or NOR flash as primary storage,
with no block layer redundancy (no RAID, no mirroring, single device).

The concrete use case is derived from the MOVE-II CubeSat mission at
TU Munich (Fuchs, Langer, Trinitis — ARCS 2015). The paper documents
measured SEU rates on commercial MRAM in LEO and shows that RS FEC at
the filesystem level is the only mechanism that can recover corrupted
data in place on a single-device system without external redundancy.

The implementation is validated in a real arm64 HPC cluster (Slurm
25.11.4, Yocto Styhead 5.1, kernel 7.0) as a proof of concept for
space-grade embedded Linux deployments:
https://github.com/roastercode/yocto-hardened/tree/arm64-ftrfs

> Well, as far as I can see, there's no write path, no read path (no
> address_space_operations as far as I can see), no rename. Did you
> test this?

v1 was an RFC skeleton. These were addressed in subsequent versions:
- v2: address_space_operations, write path, inode lifecycle fixes
- v3: iomap IO path (replacing buffer_head, per Matthew Wilcox),
  rename, RS FEC decoder, Radiation Event Journal
- v3: xfstests generic/001, 002, 010 equivalent validated on
  qemuarm64 kernel 7.0

> The layout itself is super unix-filesystem/ext2 reminiscent, so if
> something like this is really needed, I would strongly recommend you
> perhaps add this there. One feature (crc32c checksums over several
> metadata structures) already exists on ext4.

ext4 checksums detect corruption but do not correct it. fsverity
detects tampering on read-only data but does not correct it. Neither
provides in-place RS FEC correction on a single-device system.

The certification constraint is also a hard requirement for the target
environment: DO-178C (avionics), ECSS-E-ST-40C (space), and IEC 61508
(nuclear/industrial) require complete code auditability. ext4 at ~100k
lines cannot realistically be certified under these frameworks.
FTRFS targets under 5000 lines of auditable code.

Aurelien DESBRIERES <aurelien@hackers.camp>
