Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FD3DA5C6
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834342; cv=none; b=p3fe2LY1HDKOtuogURbP3x5usWHyq1cKffVJCzmv5cNT0J1CsChXuw+7JeKWU3RXakcqiOrCP0PkxQ/DRyTSmoz884GT2bfDghE3pgVM+4PEtSXIS9Ut9lZBwFZzCvjCpULpqPb3eyuwsgG3AM9lP3iFhstxBPljaJmXe4QjOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834342; c=relaxed/simple;
	bh=lfJi2zn6bJAyatZ8pqBbK6mCHq9/IlN2H29hl/6rlDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+DG3teoNUYbr3Sh0HjUKnZ3DkiAMQfChwMkr4cd9B7Ndtv4nm6FsLiVaxNoJTsZ0qlhgYFvnAHzMKhVV78GzPHisfA2OX/xANNb5CZ+IOAKvyw0QZSN4T22O1gXY+h7PNPogSLd3dHfzHFotl0lz6Nm0W1iBKh/bQXUBo/1dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW4+QaGz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW4+QaGz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488c2690057so21359925e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775834339; x=1776439139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7fcJpTq6cn1ESqOVAL6kg23cXEzmOx8T5HKoZ1W76s=;
        b=fW4+QaGzrSZeu5YRC/vRXSvMBFrU3y0k95zMnivXVZjobiApeTJ6eiCDtQNRv52laU
         rWf0OjalORDQ/pfQfnuxNCfDQdy8WXgicbNftxxEqI96UqNCdg/G2P6N6OXEiQgymLJp
         OwGw0971EoVKHEOFUHMfJ9tDE+stTrWgS6CGBwYHiOLC5TcDP7yfkJF6cPxkZnI+2Bkg
         Q19BHnGu92aTCW6tMoUojsdwJhIfxYKQ88opt9uKp6bzzEWG94IdG9yQyAh1aeEbJIky
         VLWdz17rR4wXo3Rrwvf3n4Gbmq3z+RS3BsJgFCanfbGE7nbLu5Pe7XxJG29YM1nsIblj
         712A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834339; x=1776439139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7fcJpTq6cn1ESqOVAL6kg23cXEzmOx8T5HKoZ1W76s=;
        b=qQee75A763qoXD02tRNlvvzm4bivXEa2aHP8quhYFNCaXsblwShLGj/88sau1+ai+h
         epwIjHbhM5G9dzaYqQSAHmG329RZnGe83UcA7BPE2WyEX/K/LxSOp/bXD94cyI7SEiD2
         Xd0jSNM+1eNcFkAf/4Pgij3vHLv0EWoj7i9VXf76jr+LnIZ5HqT6PnIeIlZjTz6WGzMs
         ZII3pEd24NF5J48Mum5j8LDdKNukWBf986qFC1x3UnYV36soyAMkD7AlGL3+KdXTy5U+
         LebZ7klAd0UNiQTns200Z/dj/tb8PaJprajLWfEJn1rYE/bomRxn6MexjMzN/vnGWbkU
         +xWw==
X-Gm-Message-State: AOJu0Yxk0gVUi9J3qPPOz8O2rxeQNmrxOBtiSQaxONrhPordAbdnRgLu
	qgTP/5Ucox5uDYenVKNqNBwIaPvO49DAt/7ta1ytzAGn5aC/92vQ7Rxn1wmuZA==
X-Gm-Gg: AeBDiesInAZAY+T2d8HG0qkPHIX6V7RuRZJAO7H320eEM+HaJBz9rmJxbfY6K/uq5YX
	V957xMPj6DW5NhcsKyOZQI6CjbKtyG9XCeJgfAXhS4HUWGicts5DgsGCfSSNHgknX2GmTl73fUr
	oMVaXt0NasSyMlBHEiY4IAwXNZRytLwzs4eJM+lPoe57dQthTnHID2UwPhQPhM/NVw72qlysQ50
	TeK7gHhU/E46F1BInkjJZqh2sxjvxEYJcncCJA6qao3POC1ZLNJRNwHzSFL4aRV/2VmJIy42q5G
	87UhHnLUzhKvlEUPbM6HISpNlXSi5BOXm8PVF8LxwhhcCEJcgDatZCmJgHum7JPHV3h45QgTgfj
	/Vty5ARv4ege43CG9ehduK8t695y0Rv0q8pj16T6lhgphypLjLaG7cI+O8Xt16lD10hAHszNSdz
	v1F5w26YyVwToa9FlK71yKt5Bh220aJyVio1WXgU/2UrKYOvJx8ZzQ695/koAzWdEdpd1dNq0fP
	HgPLGBIsME=
X-Received: by 2002:a05:600c:5249:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488d680577dmr44220845e9.2.1775834338769;
        Fri, 10 Apr 2026 08:18:58 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm52262335e9.5.2026.04.10.08.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:18:57 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 01/10] Add support for VMUFAT filesystem (second resend)
Date: Fri, 10 Apr 2026 16:18:40 +0100
Message-ID: <20260410151839.309554-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vmufat as an option for documentation and create an empty vmufat.rst file (filled in patch 02/10)


Apologies for re-sending this (again) but git send-email won't take me to the editor with it for some reason

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
---

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f4873197587d..893b585d17a9 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -120,5 +120,6 @@ Documentation for filesystem implementations.
    udf
    virtiofs
    vfat
+   vmufat
    xfs/index
    zonefs
diff --git a/Documentation/filesystems/vmufat.rst b/Documentation/filesystems/vmufat.rst
new file mode 100644
index 000000000000..2f7230e8e390
