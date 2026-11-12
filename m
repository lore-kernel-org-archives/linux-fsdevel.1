Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493031;
	b=GhJzoDkr0TZTW2qYBHOVo+Rbzhg/vz2X7LLb01lsARHH5o3hHti9t+7ERNUlpJGIF/Cv
	 g2BRhzAejc0SkcC/b+21JUnanU0IzihY/XVRcbciKx817fOyth02xvNleLiR3jOaTAx6V
	 94Y88i8xKiMaBiO1z54QPIWOujyFP3c9BkKpRBCOjuJ2GMayOdQXxc5wY1EWRrWh3Ro3u
	 yBiLbVOr8iHDBITCfK0iV7+4NuNNlBCF6NE+BeB4VvYxUZrZXhA+iYQmgXNRG0R95K0tY
	 MLBl5rAlimEBU+VkRRC5JQ3NEGPT2Hl9CiagphXlrWi3lPQXa4WMXcXih12jarL4tLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=W7IVuM4gM5kY+VlCkjQIKxVNfU8qqC+cV2NO5JrfOD8=;
	b=NXEY5aQq0tOmVoWdz3+/SGfFP8RnLy6z0t0T4u7FBYU5VpIxloyS6u0AfcwWiDyHNDK5
	 55qmbbeyPvusamuxLUUalbKx06Bpu/f5jzfNsoc5J7Ok/F4Qh7W3yhQwCqEU9+EsOlBto
	 dGsOpHwSbFr0BZaYHLbdzDkZU1cI5WFylpSmS8wKK844GDtaejKpofdomUl94YKkpAUz/
	 MK2aVBs0cQI5Rl+PvQdglFUL6ekG9aCN/dquXi0wrJp4YyKL25Wq3pYhgzcYx7cVOt2Bf
	 uaEi6TotIQG4mpZ4qLTML+T4VqKXa1Q07SFc1GLIijWssctxK2mMHJH1aUQhFnbgKCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBbUcmC3;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F5606A8BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 14:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 541F5606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBbUcmC3
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4c9abc1824so613239766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493029; x=1795097829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7IVuM4gM5kY+VlCkjQIKxVNfU8qqC+cV2NO5JrfOD8=;
        b=FBbUcmC3TkNMVh+tg9wiyedlSSvXNi3Z9406WpBziBrpIKlDlj5NNHzZZb1XcwSYkF
         x7+ZTkVfFCUyXjZoWOHRfjpzVtW6WtERVZegkoyX+BBhtCtHf6LctV6VsNgCgGV0Dh25
         bFus9i1wmGquJjtQiDSmWBBR4EvByqHrRHxYbuubocgxgGuB/V/akZFJ2MsZtV334UEe
         u5tmhEk4ZC+S10MzkDJXenSEKFawwFu0DPyRD1pp99MCJasPPMJ7cAmcj+NYoxwpxxca
         Xxlmv7CIj6qklZGD/w57xn370NWyL4vrjhTqvhBUvkfnPoXmRS1R1yOz+snKU5dVDUKS
         v9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493029; x=1795097829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7IVuM4gM5kY+VlCkjQIKxVNfU8qqC+cV2NO5JrfOD8=;
        b=JmVNhdSMGbfq/6JdssqWeSvpuqCgcJmF7yIOcGjiHgIfUs32SGARJtKC983lo46VN+
         /LQcvau2urFrZ5XQyJnl/Fg3CAmIpAu5T2Oyck1jc9Ixeb+z0pRkCYLlF8hNZ4RLESYG
         +nHRrkt5s2XINJ4eDlOu9C0WNKd6oT4FY6uSaD5/28A3Qipj7jeb3DTne8CZqsDaNQFW
         yuNoOjZUNQ1A/S6VRT3Au15jXmrVr9L2G8b6g2Eg/XFnOYVzxE+m/SUryRVhg/2Gsr9K
         D1QHzfkEJKSQiXcZCKFW6SMmwQwXjmRRWN4vZIvfR2s8x8uas6wyp5EQBt8/oM+0X27b
         8VoA==
X-Forwarded-Encrypted: i=1; AL+hErGX5wjCnce7/5uaRPKN6Q8esOu+EzdizHYQc0Rn3vEqPHw+6jYFZh6LCvCPFKZEFCccLg9u+xUmsgGKsDw2@vger.kernel.org
X-Gm-Message-State: APuU4Z+f5DnK1FMhaHIv+QMoxtc3QH5+wJECxNUwnPHDC+pnZaUsjH5Z
	Jw7CLCrXYUVtOEH+QGOlyvX5EStOKVHAjehDoVmf79r4ARBz9IhJ/HBi
X-Gm-Gg: AYBFou2jVCQQxTLMt3sgz7w97KCgjbECts+HnI7qv4F2xQFxTYZhj7qB57vfFr+HS1K
	LXKK4R+5FfPY/iuMyJi7Tir3SOjna8SyU7tmx+xYy2inpu6Uq0DoiSc4lRLQl/VJuXjOzJwJZqn
	YtZXuMMWCtuoKVbw4iYqwq/8VPdf0UDZGtXEuDuptMBzpO+GUy6FvTvoKj7QwdpATjLiN5wQHm1
	JL1HmS3g25lGSyxPieynsELs3Bshws5p3NETsuzay88jpBBQhA1YAuSgQi3+W1Xi8OmJogtsaiJ
	S1R88MW6pTKe1WVOpJoWx+CuZ2rEldBVg9AcUqd9Z8QmTxs5nJfUEPO1xluozgwZp+p8V8OTZPV
	gMBr5YYyArNYaRxHuk1R6pu0+XFfRK4oyC704vKQx1HhdmMG8XdzmfeRnT6+Lq0/PXF5Qq2B83u
	Hg1y7ymWC9N+mMbjt+BTz/Gd9wcAEHHR4M4ASfN3ryiYqLtRTFtMooEiP8UH029mImTWe4e4PQY
	d4kpOIH/gAfnexWLaVdVBpd4OwWkuuyG1mcIj1jTjSJ2wbv6YRuyS7sVAP7x2ookOr64SxTO/ev
	sIOGXXUhGQuLH2rmnPph1WotUmVS8AJpaTxKaJHt9NGSFaN3k+5QMgXBdNzf9Hn5Thb4NWx9NaN
	tH+AOxDeHTVTLhvTZeCjBzY+zGye+w6XgrzDn2eMNK3m5UwcF+mPXkUdaCDSu4EjGMwtBKpqtr/
	abYn1pS+Lpm8ixKRvYdTtrT+hPtgjnkSERYakJ3kWnXPZhiGhcIF2ipbl15zqY74z1Uc6sS7w=
X-Received: by 2002:a17:907:3f24:b0:c2e:4292:d27e with SMTP id a640c23a62f3a-c5066ae263fmr504242866b.22.1794493028760;
        Thu, 12 Nov 2026 06:17:08 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm360156466b.16.2026.11.12.06.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:17:08 -0800 (PST)
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
Subject: [PATCH v3 2/2] PM: hibernate: refuse splice on /sys/power/resume
Date: Thu, 12 Nov 2026 15:17:02 +0100
Message-ID: <aae0f774a25c8e2048c09919d3b6b841e2b1c1dc.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794479968.git.krystianmkaniewski@gmail.com>
References: <cover.1794479968.git.krystianmkaniewski@gmail.com>
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

resume_store() passes the written string to lookup_bdev() before it
tries to parse it as a device number, so the string is resolved as a
path relative to the current directory of the writer. The syzbot
reproducer writes a relative name from the root of an indirect autofs
mount. Autofs writes a mount request to its daemon pipe while kernfs
holds of->mutex. Together with a splice into a writable kernfs file,
which takes of->mutex inside a pipe mutex, lockdep reports

  Chain exists of:
    &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex

A splice from the daemon pipe into /sys/power/resume deadlocks when
the written path triggers a mount request. Mark the attribute with
SYSFS_NO_SPLICE so that its writable opens refuse splice and use lockdep
classes of their own. Plain read() and write() keep their behavior, and
read-only opens retain splice support.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v3:
- Use __ATTR_NO_SPLICE after the rename in patch 1. No other change,
  so Rafael's Acked-by is kept.

v2:
- New patch. Together with patch 1, this replaces the v1 autofs change.

 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd52..da5590ffe6cb 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1316,7 +1316,8 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return n;
 }
 
-power_attr(resume);
+static struct kobj_attribute resume_attr =
+	__ATTR_NO_SPLICE(resume, 0644, resume_show, resume_store);
 
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
-- 
2.53.0

