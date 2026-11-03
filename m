Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717875;
	b=l/54HCqC3dpI8QdfIKGXd41CUE349lfnQ2/oFmB9bXJx16alAkAAm0LXGhVCAzCowLlu
	 icaSSek6U8LYrG2geHdOLosb54D7snvN0G8/G4RDi8ybN+7b9ijkKV5LP/1EdPhM6/okU
	 2Ep/wtzOxHw+Zh4btmCHWfFXp7yfTz9szFMsbbEb65+YqCfVP2QHDnapPwOxltzSpsmlg
	 LtsFsT/XMr/qhdtlaD80dyyFAlub/t6XeEX4X7a+wlpsZUxTzQKVQPnOpNs0qZxuCYSPg
	 YHC/Ftbg9rT3NnwAVJ+ZFBBM4XmGjKzPEtY/yAbgzMOpn4+dC78LEl29TVDCTqjrOwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i3ce6V5Fn/mqyiSZg/eYAgXyAQ0fPbUt248njUT/QJU=;
	b=Lbi3nmws+t9w9j7VFaYcsS4USk5ORDvXFO9bM1QFmJweJX8KheTr/Xgwy2PoarIzQ97C
	 WiN+1kMDJ4O4TReX23EKOL+O+p1olr2FUQeqjvvASUpS4t6N38lBVBhAHwedAZC1GsLk2
	 y1TcVFISK/nQEk207Ja/weLEF8yHrrLRX/KU4LBdnu+C2gPztOXMn8WuzeB0q8wAZf289
	 1EQRHMjpeDY+fmnj8VPSwgRbCsFWQK42LY3oF+IdoNr5DrHVLJ1IR8n06DrZoUrCosjOA
	 mk+t+OOUWpQPwzqA71JoO7XA8le9sswMU+aVkCZ6xbPqR7VFWJfyXOQHLF9yjuUeYmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x8qJF61G;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C97606D826
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 14:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C97606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x8qJF61G
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c49b431f022so630927566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717873; x=1794322673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3ce6V5Fn/mqyiSZg/eYAgXyAQ0fPbUt248njUT/QJU=;
        b=x8qJF61GmIRGyteW7Ikwi8CKb/NK5DCUXyBgHHKcZ9Gg67wv4grBJd98VKSg/ccWyI
         tU/TkQ4qY0FCqSouDzu7zFw6uf3g95H/xnRd3xZ8Z5sf8LEBwdsVpp/hIb+2EJzZK5PM
         xl3wrZSJsE8a1bZDV6mHsUX5AeSuNdHpqmUQz7NEnrGVozt8jPe8z8vgrmjgQtmd8xC0
         sRboqJzqDy1lfFBXt86jCWJuO9orRilnngG802t6xXp/jv+fJQAjvHqoo3FcSz38vhZC
         PdZ/6YQScplUxkWykUKNqwClN6LjZl8Crj2zoFUyS5yz9oheRQ1ovk7r+UJl+hB7m2K8
         z8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717873; x=1794322673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3ce6V5Fn/mqyiSZg/eYAgXyAQ0fPbUt248njUT/QJU=;
        b=ivPhxucP5oo/vkbvqJ2tW/7tY6cEQjD0Mm5HU9gQNiMv4Z2uDn3pn7hlAcskVN+q3g
         URu0chrMWVDemNdiU0GusesAW+czJmRuCN6MRmAkXQQ22ojltOVeTvDa8nn3OPhDSoWU
         35fIm7aD53pyaq7DnLJAO5okxySBGf9UOSL1Rt7JiYaa3onbTMhcIhSUbbhTmkYN+H7z
         wYquNYrV+EF1IZnBqLv6hz2Msw0Zt4RkCac76XIngStc6DjxJ3B0zeKI8vydalu6UFdB
         8g+hGiNMkWGrRygytLKXkkre//iXa8J4nNJom1pSAyEF72ZDjbHjWxJtrD3MFIWWVt2k
         DdjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzH7zt7fGm7wPdRf0wrUnbBAdyO7KdEi/Ak8w+CuVDXwRqEWe9Gjnl/XyDorbWF0SE4vHHgt9Ypt61PpIW4@vger.kernel.org
X-Gm-Message-State: APuU4Z9QPiJtghESBY38CHB5M6nT/Pqphpdfwd+t3H54K/wcq6NtZkbv
	n47zIqrpI4L8xcNG6olyaoKeEoq9AtOoEgZTLWmXY9eTRqoqa1qTKfJs
X-Gm-Gg: AYBFou1d1Rr1lV9i5jIzQG5TLPZkGb9Eqco9UJlDUpuRTHjxqgzEb666JATAdgDNXLj
	cBHC9yY/Nr0iw3oGfe/sw4fLP8mns0dXfwfL3yhW86V2QYxk/dqHGm6Erni6q2BCZ3T7zjIKsLZ
	yUrrNMvqPvXhKRRdyaStDh9S4UG5tElo0INJrWUlg9kEuU0U28TGDWdXjd/HlCQZIrObQBNekFw
	j2nVvIFfI64M8g5qJkyIhigPZI8456qbTGVsmpUSigRp8RkoIPd1252xbbUBQBJKn+xsOh+U24z
	NJY85niVVzJS1tftfRGH9X/buoom/AChI9SZJjYmnVMunQqZXBvPfkUrPR6LlIfYX2/hWmwA0BP
	paUYFxqeM2vLh1NQcDMyIop59fBKe1haundK6F4Nlf263IRCeWRPSxEWERqV7oJuGoRYBRN5apu
	HDQlNZQ+C8XnOCWh/C2bzF3kbYwz2e0br977fVTEwd8Doh330+78vhvAH6hwJj3P/PjQUnqdwZu
	TrPWP0CcKOkBxgKkwRafRQpyWm5EuhpGIhqVFS7YfyAZyf1zf100mE73ZUb61qJhWbQfzub4sMN
	5Wv14REHRR5YXK9yrSwXjKbxC9TWZh1twgPvILxfX1mnnb3tzFIPYWqceTotccG5rL87pUCE8G8
	EZs7UHzYv74r3acDh2+yfs7pHaonP/gsf8FXBR4ZHJKcwNad7kXrj0cLTR1lyL+o1Fc02PIyuAW
	oD8yTFPsBoI7Li873wqh89SoV4VGRdpYGwzfleutYYZ+jiduJpb7a8By/qpFtkfslVsMtJY4c=
X-Received: by 2002:a17:907:c23:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c4ca7ad10edmr1125964766b.41.1793717873240;
        Tue, 03 Nov 2026 06:57:53 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebec78f3sm93656366b.23.2026.11.03.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:57:52 -0800 (PST)
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
Subject: [PATCH v2 2/2] PM: hibernate: refuse splice on /sys/power/resume
Date: Tue,  3 Nov 2026 15:57:43 +0100
Message-ID: <417c773d1719006cc85a3468dc393f5e754bf855.1793715774.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793715774.git.krystianmkaniewski@gmail.com>
References: <cover.1793715774.git.krystianmkaniewski@gmail.com>
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
SYSFS_LOOKUP so that its writable opens refuse splice and use lockdep
classes of their own. Plain read() and write() keep their behavior, and
read-only opens retain splice support.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v2:
- New patch. Together with patch 1, this replaces the v1 autofs change.

 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd5299..9dc5a27f674fa0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1316,7 +1316,8 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return n;
 }
 
-power_attr(resume);
+static struct kobj_attribute resume_attr =
+	__ATTR_LOOKUP(resume, 0644, resume_show, resume_store);
 
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
-- 
2.53.0

