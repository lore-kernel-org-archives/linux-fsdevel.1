Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442521CC51
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774247536; cv=pass; b=W4n/UH5x2buRzr62k49BrXT2lYx+1MbV0es1MzCfF6Dy93bJjuo13URN+hH/7BDvcoN9lSSU8yZwY7YMOntWq0FKrrvUG7ppQEq+3bmGbmiLQ+1U0wU315fpj7gk9EuNb8/BKwdmTeVLzLUGxq7PACqJf4hl41et8dO6DRwqyk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774247536; c=relaxed/simple;
	bh=+6s5pFKYwibbIaOGNhB5uaNyid/SkXZQF5M8D1P9vvc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TidTL8icL5eWAQEuuwVveaNHzK+9LGts/jni7OpzyI74KsOwBmt+MvW7n5w3Nz+XypHqzzmXlbAiPMJTV+lbsI+ECOl/owSCAxRj8+Ggn02FlWMwx+UVfrQ3MOAsR/CwPDBXUD4EcgqZl/YQ2q4p4D5/f0afTt87NBDfKfSAliw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3N7uCSI; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3N7uCSI"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so5451618a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 23:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774247534; cv=none;
        d=google.com; s=arc-20240605;
        b=cDLA4YrDlg9o9RTfQGrhesJPd/bIt7HIgur6qO/ODWcu2JCcnGUx5V92+7nYtU2ZyI
         LEBkltQMGG5ztQsc3dCtY6tnrLJyRU3+laWzEXg6H4tGssYX+UGoANdR7ugTZMuH7ddP
         bbxEnCASkTEq58RWrTHZp/Y9oKOoWG95foI52jPbyObQUk1m6pjrZnYkNkvqLuGgajlZ
         rwbAGFUzlEMP/wnycDbwrZUvvTfwg1keAuX2fzmCnP3XUeitkN9pg/op7MllVnB85zi3
         lcLmww5DXaF8lsW06bx1f9G9J36wPYslMn8m+rw/A+HkmjnBNQacYG7Jg5EljU4sLe2Z
         x7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+6s5pFKYwibbIaOGNhB5uaNyid/SkXZQF5M8D1P9vvc=;
        fh=on5so1iZ1tYm751VXv8x5u+l+XerJy9A4qWb/XOx/D0=;
        b=MI7WPr/uXvgvfgL47Lvo70AVMDUHYP9SrJGni/v0zvXWgI0Awh1sZkw+9aRyeMLKqj
         XpsBOzhZsBRN9YfmPfoDEjypNw32zeDHBFMHz0TLJ/GeI+FlX5lqxVzWayAFbC8x/cJI
         l4xTbxVyty83IjWoKBtGdvMyHbzRbdGprqB2G6SeWckOkaK9G/Q9+ORMyLw/nGTy7ySc
         Vct/ixjvEhAl3+NN5XHmSBjlptee7Zo2lZNyAE6ylct0CAL6vAm2CDaa3MMQn12hGqf/
         lI0QA/iD8cZ5NC/z7L2dPgduhqoK9tW1a66vrGE3ZoGUqefBSpSmbDHGa7lVkHp5qbhJ
         OSkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774247534; x=1774852334; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+6s5pFKYwibbIaOGNhB5uaNyid/SkXZQF5M8D1P9vvc=;
        b=R3N7uCSIWWm+UJJjtF6NHrWTyGe1uc9qHWSDW3oPqUVo4SCh2M7uKkYrHVSK55MLxx
         IcrGEKEynDVkqsxDDdib0gOz8bfd4Qor35DPxCFj4/I0YIf0pORGK3R9rsQAe9QSXUsp
         0hvXsEnh9Ow//NhhLowl0JJ+2zFzFCm/rTc9a8NJFB1u+Weg5cd/fXrRTa+Xr6zgN8n1
         ZfTTcohdhf2J5SmoqR1D9cMluVaCYYrYFv9lMkcVL8rYSKCjHrQGFlmSljV0CBAqoTFU
         Cqglk2i9E2lHYPIlH1x0SCnaXVmEDB+let2F2LLXkjJXhm9YEyDOTk2B2DM2iE8fPxFS
         fiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774247534; x=1774852334;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6s5pFKYwibbIaOGNhB5uaNyid/SkXZQF5M8D1P9vvc=;
        b=mVGo7+9MBfRnIS2AdcLJUZXu3ZvcimvbLf9r27hCY+STRiPmrocanBukSetKx5UL5d
         R7G7mKiRlDi1T3XbDtNwHuxGEjBXaYJsOOajsdqMhC3aDKRi0+OghGpjJSzXp1Umosxz
         rDFltRxgXZtZs85eUF/2mBs6ve+IFryR9TLf/q1F88DsS56hPPL8bygFD/gHcyFLJXS/
         gaNj4thfW4wd/bmMRiom6Gh06GJDoFjkIZxWbpIxh0qSf3ahPJZU5VeV9FS0xQBeZJVT
         3Jdc+rFAzvCPxL0XSnPH1DsrdukJWijEn5QmKx1MxTabCL6pIrUCMqG70owljGuuXebN
         qwvA==
X-Gm-Message-State: AOJu0YwPVEV6ktd4YBatnpDNBnGAYR7NJ0wx9muva0WyDZYFvs259zjl
	1C2OERt4rsqxO4Gu/ZVtCRlyAy1g6Fapty6f+KvNZptxpjYOOyiG3kpCdn8EY/4pzCIxQZDmjBU
	NXnq9m5VW+lfL4H/sCZGcb/GF78FP2LIc+WcB
X-Gm-Gg: ATEYQzwS0WTnOTcB2AF6t7pt6/+BAv9PJrYhpF1b4lUDihrvXyI7INblf9RNHeNG5jV
	yqGlEEpdUyEz8mZkUSO28RYB4aJMsdlRe9E5F4FocYFaJgYWeaHzwJ89+x+eY1TrLuEX4Vbypkz
	0rXx0ESy2llIGfmY5NrBKyZitV8PQ5ZioHWGqmNfaLTlmxPlsHClsEyiIhL+AR4Mzc+DimGs6sC
	/pVI91ihe73h8aKlEURF4M5LUeyWishJYOQr4BIvDeNb7IclF7vinMqnKP5d0ZPHdRI3hO3yCiD
	Lg2VuCRL
X-Received: by 2002:a17:907:d501:b0:b88:4e52:bfb6 with SMTP id
 a640c23a62f3a-b982f3db8ddmr777079466b.56.1774247533547; Sun, 22 Mar 2026
 23:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Raghav <raghav.original@gmail.com>
Date: Mon, 23 Mar 2026 12:02:02 +0530
X-Gm-Features: AQROBzCD-gbi2s1dIjk2v1j2Qf3eISToC4QyTkvF-xUDAc0mVvDYigkb-SABawU
Message-ID: <CABR4S-u0ruLh8F_88v-NvjGUO9wKDCCADs=TtmuiVMMwmuFZzg@mail.gmail.com>
Subject: subscribe , no mail
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe linux-fsdevel
set linux-fsdevel nomail
