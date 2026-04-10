Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391A3D332F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831321; cv=none; b=kkALZ0Bs7tLYYm6uMaXhi5nYva3AmCAwso+vfr+AC/+3fYCC/vyXIE/u37oZYublddSX//jTOkoh4XhT/qfAqyv6zExly4rTaMPvkJ2a6xla75N07rDHCUOXwbkyGCHQDwGGjEFoSTU57c2bb0ICprahkbwZaS9R79rxDXAKDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831321; c=relaxed/simple;
	bh=KgerA8Y/x6ycJ5P51eHSYv73vVpMpuC+CpiCwp3UB+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KADrAQq8Cgx2FFZ8R5MW5NnTJ7N53HhjJriwHKWkSORr6z1s1saXFme/NyqcvbWjZJ/WPVKJUMSw9wKJZYM+Fv37R+XkkrdVEkyJbIRmp4acdAcJcOjCEEO7rr7zL2+ioyOMZDdI+6U864CgTCSPsIMdlYU9AYxi6U6cmnlT8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsypLGDs; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsypLGDs"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso2076694f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775831318; x=1776436118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FJLXaWTCXlr6VNjG0Hm+UEBHUd1jA1U5wYztHVzVBsM=;
        b=hsypLGDst24iE7NwbopXqQI+sRwZ5uwCPDnUfQfh2UVbS3S2+z66gDL0pIE4l2HuNQ
         9h1SmR2tFRx0CWMGnsHzcC5NzaQwbPMwj2+KUhuJkOsfaksZ0HHXSZwYVe1Ihwtt6xSm
         n3InDFHSOAAZTJWWhdA+ddJMTGhnWB00oAziH8XyQyPEI/AeQBqgHMlgalq+XWmiAa+D
         9GAcng30XVTV10WXsKEzeEdIXG9foUgzjgiSXU0prgkK2LgV7ydIMaQM6F/5ROWKHTcV
         4E/5gkP0AbppJuwJMUEsIcrhz86wRTNVRB+7obryACzkiJSzjYWRWecjfcx1boZtaNa0
         n9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775831318; x=1776436118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJLXaWTCXlr6VNjG0Hm+UEBHUd1jA1U5wYztHVzVBsM=;
        b=AjNeURzO7ym7quTAfovIO1WlxuKCNxaqodt8Snu+muYgLnonfr6wNY0q5omEu7XUZQ
         ECXCrfSvjL3bQTL9b5RoCskDA2nnitrYZLmT85PA+JzYpKxMyG5tXESy/6jxx5jaiC5g
         WK+1UM2IkE3U7sDnVR9kQxQP5zByfqn3fBF+T8gCPRTOaiEAfnNNeu7H419YREnny1iw
         AmFoMA/ONulsw0HAivThi4RYMJCHUz05tZsGeOy6O6zUuK7tMQR6n7mAxWuNr6ZlfCK5
         EO7/6ryiss8NMRgutW55uj3ru+OMxZquFY8duayHx8L5xOtjyGy86PA2wPopQb/CCeyh
         K2WA==
X-Gm-Message-State: AOJu0YzKf9VwpDNjqSlj+0RTgZqajVPv/AMWLHoldxRdovh5migOYNup
	9nqPA6Nd2pUlWVs66Nd/ZF1vAbWvWwxkRsU2qjzJ8Z+E4o2DYoFVh04kyBROtw==
X-Gm-Gg: AeBDieudtk9Uwdcftu2tIgz/4uleKNs9fzNdWKpW9jJB1Dk4/MxFB5GdTCOgezpDNcL
	C1i+vS/T8ZayoJlop9krjOX4Ubx5sKti/e5UgsEWpK531tEmDk221UrpdHqkyP/byNegNSWlrTb
	XGKNRQMdBcUpJsaSjRyfpKvNnjo9WPZ5w425CwAN3mS3tGw0uePyaH9L7yzTBzzBYpVNvm4Z8Bm
	b4JzyDqodOayPsW0wwTEgn5t9NYjhucLfpxUJFoTQHjTr9xgREob118cd0ArDAJ6hHac0laBESd
	TRdA3YiTuIJYRpXBm74/rUtvkOl3p8H9Cl1fc7AnkQh9U9SHKfOVDDV3+maVlxAK+mmkC1l9WaP
	D+7KxSOpGGF0d+uMJPeaFbLtnZ0CF+QR4G/dzu1UjVvoTGO3NulDM9o29mzIV//mVnCWY3rfYUw
	WAL/ZJQbpVSysXvfKX2Sn6u1guvwajw7/vNupr47spGJ8M47zILoKZR/q2KzCsNIxvo1KbMvXWE
	zvEJGIoT1M=
X-Received: by 2002:a05:600c:8b6d:b0:485:9a50:3384 with SMTP id 5b1f17b1804b1-488d688209dmr41286175e9.25.1775831318181;
        Fri, 10 Apr 2026 07:28:38 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63e46a90sm7402000f8f.19.2026.04.10.07.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:28:36 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 03/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 15:26:14 +0100
Message-ID: <20260410142613.308135-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the Kconfig system to add VMUFAT as a miscellaneous filesystem

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
---


diff --git a/fs/Kconfig b/fs/Kconfig
index 0bfdaecaa877..89a37c9c58a0 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -332,6 +332,7 @@ source "fs/pstore/Kconfig"
 source "fs/ufs/Kconfig"
 source "fs/erofs/Kconfig"
 source "fs/vboxsf/Kconfig"
+source "fs/vmufat/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
