Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133A326927
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787520562; cv=none; b=eHI0XIr2b8e+7Rmrymij5VuNuY7dcdcRAMQ0GzBFfe1YKYRW0h5WxKGv1OxVPxTqSo/uUEFAebA1bfyiwYGayL908Zswoh1xcetasTWvGM3rzOnf6mXreGW8djI1ywJqbuD8xoKb8hFaTuAEkMevof3R329OIR72q/xyoZZ+x9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787520562; c=relaxed/simple;
	bh=JwIViZuujX7S8zHRTbosaUmwaaVJKDC2SUmCHcy9MJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=in+2e8fTVwzrJKtWcSpj5AZLOi25aZeDpxku7MPo1GmKBLBNdYjrhpXjfhrtPnYP0NxsyiGxXf13SwkmhmGn6UIaS56KtPVpjhqVUAmfJVjiVDd/Brnhxwur8Rw7txN3QVW2lTvCpNWvLORzxp0EjLbYpjn6Jc7/age/d8Xb/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5dsQE3M; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5dsQE3M"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8efcef23d21so17571656d6.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787520560; x=1788125360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7RJuWP2YaAjMqble/yJ9llO+9+t5BHwj8WUmHBw9qk=;
        b=W5dsQE3Md+lOSv6O+wTaKeTFbykhsIpY/c+wxaYQWJhiGB3otqPIVBbD/i4NoT2hxC
         NirVp/rpxbpEN7c7Ztug4jsS/nf5XseBiFfWEQDSUPhTkvnoAYDidqYwOahw1rhfctLN
         J/tlkl/fjFW3r6RXdQnOpO5wMbyaojzILSMuZkrUtKJFNETBLV1LVO5nkI/r1JvSmwhp
         hWZM5eUS521PkCs2kWzMEPhpSYkw1wS/37quaqEohJmNtRwKyadyXo3WsNpMH76bhEi4
         k3cZcTDuzluKFlVqP46qBzJaYDtBvmo4QfGEzKBFmEK6OlKTTpWghvfrQfq+X7s6N9EB
         lJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787520560; x=1788125360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7RJuWP2YaAjMqble/yJ9llO+9+t5BHwj8WUmHBw9qk=;
        b=Me4BhtkOWxdqIPe41+jPb2WqdKMby6NGEv/7sIkEOwFw2jGHNTAj9e0AdxbehToXNB
         Xgj3eVExTt9DIHjU19LpHdoztKlOZ2pPsLufKZWJl8VfkCcnpCch4wsil50/CLD2gAi8
         0yK12kq7vkq0p1bcnR0yKEy65YyI+to4j1Di8AoQtuXILQiQBizekR4CGBhVnuHK574h
         S5OAOgMPB04K/WnV6TMrsU9+ohpeXllCPisRdRs9lTWhJHGB6oaxfxf5g7ToTMKdp10C
         PIwMweJW0DvPv6ZUFh2T3+120/y8tC7awoohUXyyiCsWhTiaRtij5wNotkREwzGY1AHa
         JuKw==
X-Forwarded-Encrypted: i=1; AHgh+RoxYekDfbZUIhKCrl3W6D6mjLyrpVcWni/LG5Eh+q0mqHAqf3++dIqJ8FAwjtCvKjTQITWWILBfe/3cyKld@vger.kernel.org
X-Gm-Message-State: AFuF++k5E+TE8fpOv5ebkf+5OGY17rLqUOt2Gh5rIpd2a4nY51dEWjha
	C+98KFj4B1Oay0KoY4hMWezLZJnYNILRs0nKus+lwaMVXM2hTWT0tEx0
X-Gm-Gg: AR+sD11JYW7AQwNa4G7xrltBTelCw/ShqW/D8gfAnEsCSQMMqnrS4BrOH2fEXOg+adu
	Mc/z8ixjA2x3upkttXxP1Y6KcaRwQGZDBznTjHJA/tianbmZ0yLrea3E3bwEPo1uqJxd6B555Ly
	XfRAFwM+Z+MtNKm5dqKmbAwkA3jueCy57hEsJ+cvnBttKMfwfsbWhFWNxoxJA6JyMRIHu5+T3vQ
	g7/6nv/Ki3sgOUk1rMHPYNfheV4HXU0ePW69Z72Cd8NDEEJfjAlFik1FReFlh+ckcfxU8uQRnAe
	liZrrFJPsAhMb33/lWtyMJOUl+wnCjnpeHUsxdrzgQMTh3hxRDhsip9U+YEVDaEWReKu7Z/VPXm
	oqQB55JlFP8hX1jeFjXvT5fN1Mg9TPHSSOSo//sp5jPHk8uhx49jESartnFIlgFwLAQAm/YfE2t
	nHhvdGmreWvV/NWWx8K1pGv+RKdQblNZCcnXUZ0cVLB2ZoK8jnaiMjOW4=
X-Received: by 2002:a05:6214:3b86:b0:8ef:76c:cb15 with SMTP id 6a1803df08f44-90c807fb516mr243023796d6.0.1787520559753;
        Sun, 23 Aug 2026 14:29:19 -0700 (PDT)
Received: from Gentoo ([158.173.25.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a82554sm45456096d6.45.2026.08.23.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 14:29:18 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH V2] fs: Kconfig: Alignment of code and text in the FS_DAX help section for better readability
Date: Mon, 24 Aug 2026 02:50:18 +0530
Message-ID: <20260823212851.1187668-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I thought eliminating the line break and add an empty line would improve the
readability.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608240313.d7SDG2tE-lkp@intel.com/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
 Getting rid of the unwanted ":" ;that was the source of build failure.
 fs/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index e05917adcd60..a2e724cae76f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -71,11 +71,10 @@ config FS_DAX
 	  struct pages.  For the nfit based NVDIMMs this can be enabled
 	  using the ndctl utility:

-		# ndctl create-namespace --force --reconfig=namespace0.0 \
-			--mode=fsdax --map=mem
+	  # ndctl create-namespace --force --reconfig=namespace0.0 --mode=fsdax --map=mem
+
+	  See the 'create-namespace' man page for details on the overhead of --map=mem

-	  See the 'create-namespace' man page for details on the overhead of
-	  --map=mem:
 	  https://docs.pmem.io/ndctl-user-guide/ndctl-man-pages/ndctl-create-namespace

 	  For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
--
2.54.0

