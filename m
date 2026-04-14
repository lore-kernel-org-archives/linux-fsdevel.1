Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB503D0919
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161263; cv=none; b=cAWBZ5rjORrD6481EsZj17hNG0ecDu5jVzhLT5yXRVxlwOF8E/Fgz3bN1Lrz16c6a5MJmUteTA9o3XJ8QmdI4IHqbkkk6SXQMfa2R1n6NANOQoYGLYeG7hwCtSIE0j9EvMKY3lpE4+YjrgK9pJj/DstgalUiAdgK+wN3jhG/doQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161263; c=relaxed/simple;
	bh=DQpiyPZNbcYcXKHK2Ug7zpKaXkVtZXwpUbqDbwhMDcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/yJk08KlAICmhpUD+AK1WWPw7KiZn1E0zna4rGLQf6idzZN1300fqcwuGyTx03apTSgdHlQsc9+4idWQi0rcwJGLUOKTC9ZQqG1Y9EVg9+NmN0/lYmIvgZgTlrScGNVNf9SIhkzsZhFdcbSQUTqrILAJ30Dub+bjtKdJKpsbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483ad568d68so8517955e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161260; x=1776766060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SYg9UhljPZ90L0nUSlZxDYCO9P69XaU6hZAMI9+Tfw4=;
        b=HnQPnptsFLiW2q+UycGDImrT+2MnsH6dTsD0myzhWfRqHFR9+TCKUBwWSqItbRmPZT
         /PZezYwq/gzoDG4AD+YlX2Fgyfcf5tuqN93dRL/Kr8cX2ciNLnzeiRaN4+Cz8Cy9iYrC
         2fm5s+EGHjMjW0YnDTY/sVAZK/UThbJQj21SuRxWrfUJA0GBgh3E2yeHXP+Znq0XYo+X
         qN3t3mmcVKtvTP+3HfV1qCMj+MqsPvoqAtaxpOTOu3mI48+xBwnedKUKjqWNLiV2U9U2
         +CFcr8+aWYBd0chkY3h1A9jB/Y2Iqo45UZPZp8ZeHRDZVFnceRqYgEBoVUJLuOdTYQVK
         gaAg==
X-Gm-Message-State: AOJu0YyBqQZh667r3+fSDg2Z6m36JNsEhqzv7m2vROre4paRqjSs6bkq
	6vGzl03kU0OEq2R1THttK0NWl8SKlG1S6Nkl0kq6lyoctDJVlg97Xl2vYXU9Ge2y
X-Gm-Gg: AeBDietdi0FTfINd9+QqYpEnZLdsOb6WVgbw+TAkMmToSV3h28LqSGnLa2TzuvThtms
	FfeypSiGPCil0i5idBmgIUWTm8VueNy1Ea3AEdpxxkuVqrTpJ7XzgXvHdCE5HQ6jiGEOUtqTGzC
	R5OmnX0al1WmufbUkPCmUs+vNQEBXwLg2LOw+07+njrKJ02Cht+4ktXS0vix2BLmvKJIZ3FJvvW
	gtW3m07vrhr+BsurcJeYp3TarHUeg4vzcd4Z5XoBRjgLHo76UmFQ+H94z/fj7qFVHmLYQNqWsgt
	4lQpPhjB4y5X8CWd6sbDvR0V7l57A5Q8vnLzMP3bYEOFNMrzCFzqB9HnQlEcj+kosSVSmXjt/hc
	GNKHY5Oq/m1dURhh0GEi24cSei98G5dfY9sylUEV2sgE5KfYR+f1MM/wh6xw51lgpfVwJ6HpCto
	XyUhmwTYRrsojLxk89ltwvwRbFikUxZfKE01FpyBF3k2Y4TxpuLo8deR3WD/QKdCcLYlkKqg0n2
	ak=
X-Received: by 2002:a05:600c:4fca:b0:485:f1d6:2b1d with SMTP id 5b1f17b1804b1-488d6658dafmr139045415e9.0.1776161259711;
        Tue, 14 Apr 2026 03:07:39 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:39 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	pedro.falcato@gmail.com,
	xiang@kernel.org,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: [PATCH v3 10/12] MAINTAINERS: add entry for FTRFS filesystem
Date: Tue, 14 Apr 2026 14:07:23 +0200
Message-ID: <20260414120726.5713-11-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414120726.5713-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..f99e1219f67c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9610,6 +9610,12 @@ S:	Maintained
 F:	drivers/leds/leds-expresswire.c
 F:	include/linux/leds-expresswire.h
 
+FTRFS FILE SYSTEM
+M:	Aurélien DESBRIERES <aurelien@hackers.camp>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/ftrfs/
+
 EXT2 FILE SYSTEM
 M:	Jan Kara <jack@suse.com>
 L:	linux-ext4@vger.kernel.org
-- 
2.52.0

