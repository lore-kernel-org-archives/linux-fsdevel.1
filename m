Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177587;
	b=zRw0RLSrYHUIlb/wdivKV0YIZfoutBcWAaXdjgexCi2N/HMWvaIDm1ccbPoWSDstEvqh
	 SctJkmZtnKoQflJIZLQlQfYugY5oIFyP3tfEJpJUA/feNkV3dzg6gfCkQsuEYEbn0vYlX
	 cEqbMOkxCs4yaXT7G6BsQLKVvhuC2Co94AHUBbXzGAUe5iotNuvYLJ94yjmkatWYWbXgW
	 4niXlsTF2PDH184U19NzCszoQktaiJlwMPP2MFLvjx1eLIRlhwDT2P5+qVVydVUJRdCun
	 p84h2110Jsdj3yJgNbO8QLC4RzNf3glmz4QGsTtO0wd0AuM1ALdD01iKhfLYvtMXTiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
	b=FSO1VR25gJ5xTs5Mkz3g5lFANMBE5XCSBt2rt8c/w+QGZdz39ZhBU83SBiWDuRXrARHV
	 YzJAlkIn9olAvNlzJqIIXSX5WILCHIptCQq9xSFFYIBUp2Ptdj50509f8hdL3TyRJMOdv
	 uhZFm30bekhVRFADib9wpuTk440qoHIFHmTI9G1VpYlhHFD8AIJaP8+c9a3vfymMUh+Uh
	 HSEDPmKfqdjFiOvjZckBSDdfXQ1i9+B4gmgcj8qPFQuzMhIsvQ2skAPKcvXm9mMGesOax
	 OqyYWnqA8mGaMpdEDlLs8zRrYMEcNiDIGGqhLGJ0f/bZSxCNWugx8im27VvrnjDqKDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="WiS/rO83";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39A606EE81
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 22:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB39A606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WiS/rO83
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3724667bc16so320742eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177586; x=1794782386; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=WiS/rO83jd9bI/DieSANeabjGnOf7ofkVqtVbL6lwR0Kl1aPmAlLVRbDPbhxCKXHqz
         CNS7naH1rBIwFk3gS0nzJsWAUVUev1LyzwShyBLnB5296dpufWK5/WU8Bse+xdMATfWB
         jaACnxNWH1yWm6H4lhdXSxvzyIU+QYSLfFSG4Qy0WpJ78qLBfr3TMXGLvWjWFAEki3UY
         WYcZF1lL4olsSD+VMeyHsPJH7imK+79Av1uXyTa2G7gIv0jiUzGFoMsFRMQC5MfUlflo
         2HlWIU669YLFvTS6JA3s2ktN5HpFaAE6ptToKgVz0mTlheIc/dgUGTGlGWkDe22ir7Be
         41fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177586; x=1794782386;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=drf0prmjokHQD6ELEu2aHRs2ZMf8gE8fiHn9QvE151XMjU5RPrlmwhWM4w0BM6rQSW
         WaOhbDdYucMIpLyMTpw0LRjDNajmDomSz5/qDPPKXRWL0z/864jM//XhZe2fAb8A5NmH
         miUYiiIO17X0I0x4jR/0U6CzNfC0QRWzzso7szqjRlghD1hS0NLcV7w/GujuCoJC3DyY
         ZtSiLxPFJ5yvgDb27yiISoXYB7DzNcJm4gnXzmUfe6OarFlNX5b2Kf1XpngOw1Veo8RA
         eFOVWMHswWTs0YHVt10ICKgl2W1XPPnjfmgAAZ8D1bdkrzh284fTmsf9B+W77HTd4hvq
         GA/A==
X-Forwarded-Encrypted: i=1; AL+hErGhU3SLOumIAVIE1OqTnh3e73z2hSP/vazGBfbilIVotADxluWULJkSf6WhFoxjpdU6hawj4gCcOTb5m2i3@vger.kernel.org
X-Gm-Message-State: APuU4Z8fEJOb1KHQl/A5kOQs306C+SHjTCvqsspYwIn5CAW6Re4CBqFs
	isbMm1XLKYK1WXaedmn9ZDG1lRuvr3M+naso7V5GMfZlcSQr2qYH2NJKzXlPdr1xe2x2KkKb8/U
	rdBgM9mzAXQ==
X-Received: from dyx10.prod.google.com ([2002:a05:693c:820a:b0:36a:eec:f68c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c00c:10b0:36d:dcdb:70c5
 with SMTP id 5a478bee46e88-370f7b8f918mr9710009eec.20.1794177585797; Sun, 08
 Nov 2026 14:39:45 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:07 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-4-irogers@google.com>
Subject: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog

