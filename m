Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6C1E8320
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776598534; cv=none; b=WJS5cZfMR20NFNz0NmLs4lW9qSmv8Dk84M0hzWD+ZCUq07tkChEhdVvAoQUb08UpldhxV7Do9CKjuA0Zz7OD2IODuYl6RmUiQF9lSS6Ai/GYRVlhz3Y0UmvqNqIJhmvIH1fOB3InnavGXGJSMDeHlC1VZdBPqngoAhzudOmwW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776598534; c=relaxed/simple;
	bh=YjSAVFoqKbqk3zEosTjzb2YAPvvD5eA8kSaaosTWivA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tE9ohkWbIRIlXst6rzHel28GIhy/Zaw92XXwgYdxbbEBzHkgDviZkaFoNylXatAbvA19XiI9m0XK9M+Cz3VwaN1UDQfTim6GERj8IDpO6KcxM8+mB2aEnnJIvIellmRpGOTobrLsQwq1wjyRGZyDUaFQXCfpSH0OMK77GAmQy0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIaoKm5y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIaoKm5y"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so298217666b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 04:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776598530; x=1777203330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5BsTegZtnPZR/6cyTsMFlmqxBr/74+elJxomXLIbmY=;
        b=VIaoKm5yaYQkhQrEMNoso7VVVvZyFIUIRLXWSvIzeVXFlpN2rojhuKK9j89xCxAZop
         QV4vnVnuTCnJvLEmSc90zNGHXNs9WD7v0QjVdNn3wFoXc6GmjonfUwsD8D8B9zjnAIi8
         DACNT9fLP4TSevTFokl+wjsuqSFOIM+fkC8hZQZDLxiUJMz8LQIuBMv8H1/buf2ML024
         EGtgpNYxeRTfcJEMCZ6dqN12I8rh1QQQtj8/kT4p1Yv6Wpw5pNfINoKd6j6fQiLJRq7W
         +U5M3FKAL/AZ7IbKlKzkcWoPMImuMmUKME3cuLIaWgjhfjPkTb94w/P0ZXQFAt5Rwqra
         0csA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776598530; x=1777203330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5BsTegZtnPZR/6cyTsMFlmqxBr/74+elJxomXLIbmY=;
        b=W0XBN4uhw//cegZgO6gTB1uHZnIqJ8zIh2AyCUf/QWyvET/SzprrHuCrXWqHbXxcd5
         Zzi54QdzlwXXZ5t7arXWREPcENo5Bv5QotQZxiMfPr5yuYkb5z+lNUVPcVXfSkkwIT+6
         YJYGHDZjV7S1y0c2nWprCWPoktu3XOUOyTl/KelJAJzFre77Y6b8ZpverLuGpfkhxAKT
         Ch9fhd0w9/IflJZhS6OVj8xS2gGQLm3thUqB/HpKyBb2Y+sjFPEc4Kd0cH5DnN/74+7b
         dHSfICj18IXN/qOzZSCKfxVREuCvfFwJF4nqAbxaylXHMg7mQ6wl6f4ukFmMY0G5YnAK
         C8XA==
X-Forwarded-Encrypted: i=1; AFNElJ+EZB26RyISVKl05jhXYifmaXiy5mEX67ou6zeoVCE05udglexl2mgEPiH2steeos2IUMGCzyIauCpAhGp1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4beqdUxCPc4XmB6Ro1IGyTfqk96KSvdEgjEHH2oLIJhNcZ1t2
	szoODDiyGwtt2SKWuQhZDcpypQBg+MWfq82bOPXcczKgBiMrReOIotMiMg212oPN
X-Gm-Gg: AeBDietja1WOhwhs5whC8EZpWlLZjjivg8Rq4wV23jOokIQcpjiNWGy3vA1dfon8Pqs
	aSbePRcMtbIcnJhX7CWC+XmpKmLR8vnojQe3hAK1lsfPEfqDM5tfnr2c5g/PnoNviOlU1GgBzEf
	i1xxTKBNX8bVJN11chAdjfJjBMdQ1zIe33kokQZkzEY7vvRlemNMN45BVX7dRHMN9+n4eqLzlrF
	9MldTOGOZCgIFpWMqUV8gg64MHJ76o1MlY7BEq+lMy2c5sZNZlZhxbsFUN9r8CDu/Qw8ZO2UFSl
	KpzfFcXDlKO71NDrryqU5EI5upa2RomAj99PzPaKLDDgxkbGlVvzxW4GlibI0F22sum7xRJd1HJ
	QHUb0p21eBd89qbTC3bcndonWhCs67IOjEXNCx5MQTvZUmv2g43jxosU646Wuz1h2LOjQpmnt2v
	9sojXMdz1Nn4VHFmAg1WSoS9kU+aOv4PLANgChObc37oPaqgGztlaLQN2UpuyFlEOSZrngQSp7i
	9DaV1nvzW16G6KS1WU3Q5sB4ryIOVS0RVcoFd5Vd5qGbKD7
X-Received: by 2002:a17:907:3da9:b0:ba3:3091:e56c with SMTP id a640c23a62f3a-ba41c1b68eemr414787566b.14.1776598530012;
        Sun, 19 Apr 2026 04:35:30 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-ef3e-0116-378f-2ef9.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:ef3e:116:378f:2ef9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45121042esm245634866b.13.2026.04.19.04.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 04:35:29 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Joanne Koong <joannelkoong@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add new fuse-devel list
Date: Sun, 19 Apr 2026 13:35:28 +0200
Message-ID: <20260419113529.1523179-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new fuse-devel list in FUSE entry.
For now, we are not removing fsdevel list, but we can consider that
after wider adoption of fuse-devel list.

Link: https://lore.kernel.org/r/CAOQ4uxg+DhWoKtHFOt4eEgYYqAAmcJG_q3nJcQ2ZVOFCWRN0bw@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7dc9e6fad2ea..83f2edcd22769 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10519,6 +10519,7 @@ F:	drivers/net/ethernet/fungible/
 FUSE: FILESYSTEM IN USERSPACE
 M:	Miklos Szeredi <miklos@szeredi.hu>
 L:	linux-fsdevel@vger.kernel.org
+L:	fuse-devel@lists.linux.dev
 S:	Maintained
 W:	https://github.com/libfuse/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
-- 
2.53.0

