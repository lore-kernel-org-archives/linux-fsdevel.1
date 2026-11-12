Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493028;
	b=CyzAYwK5j8ePU0SVQO0i8gi58ZJzfL7iHK9mVkYZxFGIkE2vAf8y/2/lRJVeolmpRVEh
	 gegkXGjRSy0eVYUo3TS9UKUfYTgUqq+eXt/+SHsURIunrmTWjTL6BMP+fCS3ZsSm8fxIC
	 Sf6ftZK61VyJtVRwMXU3fb4c9BvQykIrVkL289ysmGk07P+RRqVTWIbBsyUj67dgLodVS
	 oVAr4EAGHfp7tQL3ylmbxX9Eqhegv1qLEZEusSaEQGHpAo2XfCTw4D6APkDKjUTiEz65N
	 7aKZ77eXqt0XfkVCf5Dr/NxzApakFNYKurRPaO9E+N3uCcAGl0JjXNJ4QFwRPjbvbfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qrF09GR+ihkQ4thcmIGrsAzK57Wx7VRqM+yLsEJ4p3o=;
	b=uGXV/2yxBMWaP7EGc1QVDyp8e0eRlKV97riTfTD1Z19rnSSIqlauv9j0pIOcNUkUjP25
	 cNbxCjwz6GGglmkN/ACdgZUoWtYnUWvLmzYcLQ0wOgRe7RUu9ocGTBDu+mACFTBLhSell
	 GYmghT8/EheeMbcsryg1TEtOPpj4SfCN69XqKqWkenyAQfT0iImHrlOsEaomkOjFUPEL3
	 2rhoZaVYwK8YKTV29AFELd0P8KjUeo9e7r512r6P9i6YpDpc7hdR4Gqa43v9qBNIvosm5
	 rFLqpvEWjQtlFOU5zNaInKXMkaQfrX4j6tgCj3BttywMmnn7pwAKl7Slgfeidu+bbWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BUc/oAiX";
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3A606A880
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 14:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA3A606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BUc/oAiX
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4d21051042so676308766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 06:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493026; x=1795097826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qrF09GR+ihkQ4thcmIGrsAzK57Wx7VRqM+yLsEJ4p3o=;
        b=BUc/oAiX8fnhkktLnZFvgLNatm2C/o2PyMn9TAlcNkOqWquh+iDGcpCDApB4TUPIJe
         szU1ye7M0VlqedHpuHo/UjjBFRdDNznR8n86L+9cZfulBPjCPrQtsGj7cS9Jew+uiz/j
         BPM2QVXwGTts7clvGUtG+K8M67nUK8uC0Cy7JTV+R5igmEOwF9B6Ay83mcEKDbgyCzU8
         0ba3S1RFeRz9kOPxUzfcbou1wF6kupEGcm1Essy2qdmZWVGY/Xt6wD9LDnb1R/zYFUWf
         G+vAbannvJsIZA29ZLhmQMtaQPfFA7Irx7D2rAaAr+v3W5Di5r++BfmcU77pSyYkI8e7
         hmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493026; x=1795097826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrF09GR+ihkQ4thcmIGrsAzK57Wx7VRqM+yLsEJ4p3o=;
        b=dJF6K/RCWHCDcUTEf13QpQ8EWDgz1iDIAOCBeurc8COcxpqSFmNydConWHOh4Mm/5T
         jo+YMszMJQcDzvSE2SWEM+TDvrB79GQ1uuxFYpfmwanS0/6nP0to5M/zs0N/2vrPzq6Z
         8HADeEBNwuavrvVi3ze2OVFzwYSPkRGgXQPrZJzt0kyvJyzORgQeJ9rxu5LM5fHHHqz4
         lLrwzLqD5u+oHOCRmzL1txpHeZBxAYTHnDjG4SovmkUNa8NDVFYg9zWp0MIPCTlrdTzJ
         Gfh22V09YrKAXqxsPrcUsfdw1qfrf4yr5rAH3dUOiB1Z7ISDzoKm3ral72pYwcdRNaDs
         f3mg==
X-Forwarded-Encrypted: i=1; AL+hErFS7m+9qXUC+65d0G1PUISrr7r//8+yMEIL0jDx6Xhaf9XQmijc1Jw6e3kgnxA1Gfe5MOxQFW95ShEbGndb@vger.kernel.org
X-Gm-Message-State: APuU4Z9TOZMiDw0t1Lbj+UUw70j+cQ1gvHJ9m+ZhhjOHRjoROCRrAFIT
	DChM7YDsdSvEkORPt92PVaQAq4iNMNNHM7WL0OTwVFokoO+n9xrCaUyS
X-Gm-Gg: AYBFou0WzhzcTYI9QtfHPz6etT+4OVDWNi+kSRoUF7XLXpApZppURMEgkhW0y8CXmtl
	zOlN7JEwYiez9TOXYQNtG2rZipocFVhi4P/yesxsM2jDI6/WrFqbJwwUnntiNhnjPRwCm3tcbDm
	zaqrK861jiJ7thD+rsP6oDyPBU2aL0T3AC/hUMQ+wnLRVkyajKu0Qx3JKh1xOggQ1/xF+Y1YLue
	ooQNoV9KHcVD4/VR2FmBwKJREbIdrCZzEVtUk74JgBRT8mYII7hx0kNwNosbnDGHbXqaFB81T2x
	SUcFfAaBcACGp7cEhWKEbr1H0LWJFTVnY8SsQiZIMa9YtQT4+6rArXinnGR6xIzbQ7cYy5YLvAw
	KRQUietfp1ARNZxp4l8shIecon8iagq/vgsCc4uV5VARWHEs22jH4ufCpVVQ3biwSGFovhtnCOv
	9VdZePOQ53W9PAvnsDKwNwmm8eh5ufULxwzpTebhBTmLvnercQeqNXw1zcwCeZG0Y+Dqh96ad2X
	xPMFDa0PDtb+o6hFWg0y3geVfLj8fxSp9wPVoaIerJh7Nys/IP5NWGJh1H11SKbY/s1QXEPOniq
	L7cbnYoqxDEbHAOjIuGOkdlJvLqawDNG55Oi3KSwHpAMZrK3fX9A2l89UGbWM1WzXqp7x89IXw6
	fG5CTy1Km/NFSIq1emjoxHaob/76agIu4OAz4n0Bbseu6ULg2aNqJMH0Ynvt3Q4YQCKPamkcqz7
	uD1gazpkG9pRqUeXJaizHEl1IGH9I2aDbbD1kRUocECBt8AH8S/Q==
X-Received: by 2002:a17:906:9fc4:b0:c41:5a0e:3356 with SMTP id a640c23a62f3a-c5066cf82b8mr489669866b.41.1794493026263;
        Thu, 12 Nov 2026 06:17:06 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm360156466b.16.2026.11.12.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:17:05 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH v3 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Thu, 12 Nov 2026 15:17:00 +0100
Message-ID: <cover.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series refuses splice on writable opens of /sys/power/resume and
gives those opens separate lockdep classes, as Tejun suggested in the
v1 discussion.

The reported cycle is assembled from two operations. Splice into an
ordinary writable kernfs file records pipe->mutex before of->mutex. A
normal write to /sys/power/resume records of->mutex before the autofs
pipe locks when resume_store() resolves a relative path.

Patch 1 adds SYSFS_NO_SPLICE and kernfs_ops->no_splice. Writable opens
of a marked file refuse both splice directions. Their of->mutex and
seq_file lock use separate classes. Read-only opens retain splice
support.

Patch 2 marks /sys/power/resume. Normal reads and writes stay unchanged,
including a write which resolves a relative path through autofs. Rafael
acked it to go together with patch 1.

Other stores also look up paths. They remain outside this minimal series
and can be marked in follow-up patches.

Tested on v7.4-rc1 in a QEMU guest with the syzbot kernel config.
Without the series, the C and syz reproducers trigger the reported
lockdep cycle, and a splice from the autofs daemon pipe into
/sys/power/resume deadlocks. With the series, neither reproducer
triggers a lockdep report although autofs receives the same requests,
and that splice fails with EINVAL. Plain reads and writes of
/sys/power/resume, read-only splice and splice on other sysfs and
cgroup files work as before.

v3:
- Rename SYSFS_LOOKUP and ->may_lookup to SYSFS_NO_SPLICE and
  ->no_splice (Tejun).
- Drop the mmap, prealloc and binary attribute checks (Tejun).
- Add Rafael's Acked-by to patch 2.

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

v2: https://lore.kernel.org/r/cover.1793715774.git.krystianmkaniewski@gmail.com
v1: https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.com

Krystian Kaniewski (2):
  kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice on writable opens
  PM: hibernate: refuse splice on /sys/power/resume

 fs/kernfs/file.c         | 46 +++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c          | 18 ++++++++++++++++
 fs/sysfs/group.c         |  4 ++--
 include/linux/kernfs.h   |  9 ++++++++
 include/linux/sysfs.h    | 22 +++++++++++++------
 kernel/power/hibernate.c |  3 ++-
 6 files changed, 90 insertions(+), 12 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

