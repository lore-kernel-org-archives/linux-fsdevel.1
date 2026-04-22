Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90A376BCC
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847885; cv=none; b=sPh+H/NL4lO/02dEQlQU0Q098Gi9Id3qW8Hdv6EwTvgeM465izrshN5ZUFUn/Bl7tujxljnDHzmhJK+xTDF0KWlrfvW0HhF5Fo7dKvqbdMZbqvY4z1A6rQ3e0gT+bkWBNbhIzYZrnmiY/jn93OBRZVLr1Bm/eRsrwBDmWmuWRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847885; c=relaxed/simple;
	bh=m8RPO+3IDkr3Iy0tNuGqC0k31LXCKZrz7983xYNXXVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvNVroilW7xQOEjUshQ8VpiU0bo1mZR1c1AtHj7BO3+KoNRzFIHu26w9Cwr96Q8O3O2lZCl7FzHOpCsISYffKmZOgXL6xigWpx0F6/Gq5doxA2R329nWAyXdnqPqr98UQkKQcMq7JqskqYAoj1rNWQ3mar+soDy7LKfe9lJitRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rL9srZ5Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL9srZ5Q"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891cd41959so32593975e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776847882; x=1777452682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgUln5U7+dMee0Mhdvyj5jw6YLdxHm/vO79Sdqh8h40=;
        b=rL9srZ5QOHqxggho05vkYJNNAu3qjOhhCppC4GBR5r1vmpwrA1Jg41gReYir27jcEF
         TepHRDgMy/TnELwfckY09UE/pShZF98MMQEsjp5HRQ4ane7A+M2Wv9tMwH4TPUHyjDno
         s6wUBgWnEK90ykAMDo3oHjlczLng1CdS6RYbYXGr9is2fcWtUxJsgAOL4ltBobgp10w4
         aqxXzpgNcTX2cpnh0svvcGlU8tNXsOzaY9wYL4QGH+QUe3+NOtpbNw6rmFcptu5AcNCO
         vm6BTYOX6s4L5GZ39IHoMQZ/nuMgMI7zieshjpJX1o5N/byD+PvdFJP5NmgTt8E+Xy5b
         GGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776847882; x=1777452682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgUln5U7+dMee0Mhdvyj5jw6YLdxHm/vO79Sdqh8h40=;
        b=f/9D+oWVCT6yTaDjNM0GMZ/kjrGr/ljUcsrre5UFZS3Y/AYRmWBzDkKk4owysHYF4x
         0Zm6jOucik79z1gsmCFg6twCY5g6tfpC45/l7pkceHzwUCo4SXWRXeksRHGHMxgRdqxZ
         +zhQ10eV/1a48aF9MwiFvHkskKBN5y6KZv+7xSrkg6EbT5TEEbunpx0wbFWWEi7Xo1B8
         1NjO/MAcIFAjwvgxEZoJpIgjIOHm9Ropnc0vkF2EUnTqtkX+sBpvwTWX+gsbSyBGPz0p
         ZruytW6lASbm/XRnfIluY0D1O8LIo51BPRZKgpV1+AW7mBueLlOifEQ0CuPBHzVl62Iv
         1nhg==
X-Forwarded-Encrypted: i=1; AFNElJ+FD6ZJK+V6HzTKeWz2lHyqLcwNCUOk7yPPK3jiARpxq7m+iexsYYDrfo/IW4iYdqdn1KeGrjZaeZWD/6Kf@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRS7hZwFpXS/yS3S/dyL+xurlaRsag77x5jPdNQbAhfGLshJ+
	UV18pT+PPK9FXbeYfswE4uJkQQfZGvCZFFmhHQgeAzq4DDL73QA1WvzJ
X-Gm-Gg: AeBDieuHZGlxyNvXbdFoVfWFCBHiRM+EQrfFI7iHmkbkRhNiy+Tx12bBFcV0eSqOdb5
	q0g/veQrZpn1sCJlFOQnRUye4q2SWpmtZIT2hwjTJGzrkE8VCd69LX1pIBlj5VebGNSl45CVkIX
	/6KpJWAhWgwpGgYeeW4WVEwBza5Tt5NFjTiH/nj2/HzHPeqH7/NrfIIxAbcsgkzIIbxWPEXIBMi
	oqi2sX7xm/SHOwyEL67Esdn3fFcl9Pu+9plWHoApZOK3VPiiPPVPmfpPD2eguaKaFxl+Mj2R4iZ
	QlEYg5Ru0Y9lJAd7rP32cliMTeLuXEMeZeD2EDTHespS9ApheQPdFpJ5iIc6D340fgxCO3vA0T0
	kYG0A/JZKUQUljbpQVQrMkscvPdIrd2KR9Z7KLdQZQMdxdjlQnYulBUGi7m2COzSc1NsE5TP/8J
	isAtHLSiM1gq0fps6Bw69f85SJNmAujw==
X-Received: by 2002:a05:600c:797:b0:489:1a3a:9e45 with SMTP id 5b1f17b1804b1-4891a3a9f38mr116070245e9.26.1776847881916;
        Wed, 22 Apr 2026 01:51:21 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc10019bsm443179525e9.4.2026.04.22.01.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:51:21 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: amir73il@gmail.com
Cc: brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Date: Wed, 22 Apr 2026 11:50:44 +0300
Message-ID: <20260422085044.339428-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417142503.1436446-1-amir73il@gmail.com>
References: <20260417142503.1436446-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amir Goldstein <amir73il@gmail.com>:
> +  and the filesystem context API (``fs_context``) for the mount path.  See

There is no need to say this, because there is no other code paths since
this commit: https://lore.kernel.org/all/20251212174403.2882183-1-sandeen@redhat.com/

-- 
Askar Safin
