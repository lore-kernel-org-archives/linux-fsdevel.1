Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116360;
	b=sL+E6PicIeY3EUTFLKQE/4WasWRAcNUtJs02fKzAiSl+cBMJ0NTEF6MsDApyjDGhC6Co
	 omig+qYD3gbBEwj0j4Vl+dbgcsGI2mOzSGhEreWR01Exocop+OGJUIW0wzO7eZiilnQLP
	 UZk2TDYsaUdyXjWrmyYt1udFH8tpO1kjacC9bK4fEO9D5LDVYLBeIY0lA6uewKyOstp06
	 KPh4YFAD8dd4NWNj75RfcKSqcRsqON5D1bvFpzO/PAj0XkgJYRoDAUjFzc/wjdsEWM3PI
	 /RqulESWG1lWUT+99YcvUZ6tJMlo81FWfeLPAEqLk/t5TeIlsTq9nJtH2Mf0SabtdEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
	b=ZJ7NzNYRUrFxEN+Hj2kLZrbOYuqv1+4k3Vge/o75zoWDCJ55Rz+wxfhVTgSKSiEI6PXk
	 nt/D3xip1NuRrD0H/lT+I7mLNUmRtFEqgCcKlVSB9YiWvFhaKRLVZQRMchAbjlLmgGFRd
	 SYdPCT6wp/RgS2TWtL2hyuVs69pJ9WYWoQE/OismCdE0alouM9WHzIgkAAbCy/t0OlkTA
	 QP+nsVk1pma5LTU/mLK0i169dJpt5YCKCCznRBGZ1NFDkhO3R9gbG4ofOeZ/bvnf6ByJI
	 pyvXnzygnn6Bm2cUY9V8jaVWFhHyCmiCwdtjKVZxuh/aYg1nnLYx3yJbmQtxt4xNOrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D+q8GpbI;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7888F60A2613
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7888F60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D+q8GpbI
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so110790b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116359; x=1795721159; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=D+q8GpbI4NdO7QuDoNEZVES5pOHQO240I7HDWjn1f2rrdZCPcnuN3whOXGpx0a39oF
         vy29NgI8yDcoBcybaw2tN63zB7751vVbEVZZn/LzCMjY9HBRS20Keo1KE3hlO33zrKMY
         i9rsNYFToAMc7x/wdPBJ/4VyeJTA7enjCxjXgL3JsrE7hQmAx+Yowi3dVHZ+q9R9WTsa
         Q51KrqNHmyCaoJot9RTu5s/hbSfngwHvYv+jm5vhy3LwOlq0rIMZBhXUMFuk5WVGWCJ5
         g7VSQ0AS6OPJKeceOFnEmsage9ERncv5M09VAiTQMd1EpN6QJylgkCyMQrC/nJS7o9QN
         QLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116359; x=1795721159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=i7/nkZXgOcuOE+cHC5IxQCsdmCZIG88pVG4DHpZe/77iNiYLpr/ppsegVYjvlVJGlP
         t2w/V6sbGEDNhZ4sucmTxoGIDdOjmiGdL3pVeBSKLkK6baOMjhrrMy4gknGGUXqqFrLL
         eVfrD6GAVawl8JL5LmgcOtLqdXMtX9ZpIAKmKqWvC4h+NmBDEVA52asffVk7P2my+e0A
         VUGHCHSp12R7+7sWmwgxzWTrdzhKLRmM1jeacc9G2FkaFCtr9bgZDE6POUmJWkr2QyKO
         jKmxYB80RefKunM0JAJEDZ3VBrwk/qkhJ+JdPWJEoCLSahkPoNDGyxYIRtRIlpnfmwFr
         bwwQ==
X-Forwarded-Encrypted: i=1; AL+hErEeAr5mcp5CnIwxXnUn1xor1cqFJJ2S8VaaDEJkV1DUqe+oqLjPJk+bSSQRiMhc5GmX3I/VIAMD3VM01D6o@vger.kernel.org
X-Gm-Message-State: APuU4Z8TV7ww43lidiP+0Xni5ALEZVyZBKvyDx8+Jyiy5anWPtrYydWH
	owOglL3DT2BFxHJ+wQ6Dxct9JfjTqFypRlY8sQsb5tYrqCF+Pf251eVt6pialCOmmaCVdCHftPI
	u1OIn5h1Igw==
X-Received: from pgjk11-n2.prod.google.com ([2002:a05:6a02:81cb:20b0:cd6:1fc4:6199])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9191:b0:3fb:1bfb:ff29
 with SMTP id adf61e73a8af0-4014e74d624mr589862637.69.1795116358583; Thu, 19
 Nov 2026 11:25:58 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:17 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-7-irogers@google.com>
Subject: [PATCH v4 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
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

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.1.708.g77570a6a1d-goog

