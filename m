Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741463EF655
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906683; cv=none; b=pEioNApLSEyFRE71K0cSMC5DL4f8I2+YvmLopRKzWM+TUz5k1t8Ft/D35c7vDvqgcSmdueoZnaRwLmsfiNE1WxxAYkN6RReKUtKXcHdYWOtZmzpefZVOUR5z0/c051F6w39cCzPTVmDZYYZzK7pn/W+A9HWf+W91IKj0zgFNLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906683; c=relaxed/simple;
	bh=r94AZzJnXSbMnbxI4Zpr0SaVeS+ejS57fzXN72xSV0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr4AE+uFguzH8tUycByERAf8F6U6jkdA59g9uEG17R3pgYm4Ksn+luYwJ0T6/yQFiBmp//TT03KpuqSDTRYjl6zgPcvWK87n2TTZb594xLdqpX+whX09Ekg6fn0A/I2H7xme/IeX6DVmmt3xJdsk/4ZKNWsGmPibdQdEhK8rxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix5kqDsV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix5kqDsV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4585a116a4aso10032850f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779906681; x=1780511481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2TLbDUJP7Tpmwrt9EebylXvF9EPT9xRZzNZOi9eErg=;
        b=Ix5kqDsVq1UppMd5pv/mhX/nf1bKZwn8OtLU7KJvsQihhTJD03PbMDNTEIihKw37p2
         sn2uY0VTPbDBpwbt++3zyhlpcsPWBpTKfpaImKv+bCzqGVT5lciTMWpP0yc9YY6zWK/k
         HXQr9ftE2USst1agDAaPkWI8257Lisi1ZiYaDXAlhwYhIMGWWhCyYdfDr578BVulxfFD
         QMbzQb+mCKYXGfCGZJsvuh8k+ChtOya0uQE+R4bmvLYx1CVEsijiSHNmCWHwXwzanYIR
         Ab4uVPiH7NihuzT8Ia2uevzDb89sxqfHF/ABuoh9UkRRTZMyPsTjXZRKWA9tGnHDEh65
         vRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779906681; x=1780511481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v2TLbDUJP7Tpmwrt9EebylXvF9EPT9xRZzNZOi9eErg=;
        b=O4LiB9hEuHVUC54CakYCuRE+xG1scitPrMg2yTn1PmURKpbEUV2g3454xBVRxJlua0
         nkKJgjtwBLAkZmRIE9ujzXuWtLEgBQ0mfmp338ZOWhjrBjarS9CoAZvflg4vUhsLp4cv
         fRJVZkplTLncKrGskuE7PukjHW1Wwfj5BAHbwJBvzRoOgL64DmcD6NK7zQb70kyuFfTp
         cPJPJBjb3FewtybiNFjqydpBjjfSAgonH/0nw6NH530bDOrA7p84oRqc+HaqMlFQv/w0
         e+4mFN22gQR/LzSVzXBMOO7zrdCrCDnrf5EwcfFS8221gzuOD7+4MUHB3d6MAAO8wbBa
         DXEw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZSpyEtgSS4TiC50h9sEStPcLzYOKsu6joRnya2hmHTtiTvJ5tVwB8Ym/Qka2cUdPCuFfpt5LqqO5nafLS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UaGXJP/t0AGtc5zzdkSXGsqnPM98pP6F19hkpGcGLfmUUdd6
	8M1GEH0cTUeudp32+kTtCSCYYqbaoE7b2XZJVOhIu2uNd+zdXUSCvcem
X-Gm-Gg: Acq92OHNBFPGoVtIcUIM4mrBxvOllWFBH+awXaDIl6EgDvVOro9lJiIvgATXqab8IdB
	2oVcIVvu3aRpuWcqKfsIpUd03bDBW09Z4Vu1d2K0NVgyUjyfwCaQkO3gW0fbK8iCBXobj8+GmWX
	9yZ34A5mpJMhCDNyM81zGxRT5dr33Plr01vOIk805gr90PLKba632aSSybT+GtYmTzPDVphJGP9
	cSkoB1rB+KmQ9Dpgt9ErzTgVwLQOgOvE35UNGUJv+izYQKdsG/fFWMU+/CDG7zqg1P0VkClSUZz
	bryQPNoEMvupzdlMV4bUkgQaExyi+DLX0IRZneT7uCWiXFp4nFWOiWgpK6G5jtlrxZCTZsy6suV
	xqXuxcO8VzN/3jCZoeW5tqqww1MQk0pP9b42wnaOe8jkiEkIpP8g6gNNL2J559r/aOigEwtFNq4
	YZKI85ov9bXY02yeajn237XIYT+x39mQ==
X-Received: by 2002:a05:600c:4510:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-490428ddf15mr379350205e9.28.1779906680441;
        Wed, 27 May 2026 11:31:20 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4908b5a7a48sm573105e9.22.2026.05.27.11.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 11:31:19 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: jkoolstra@xs4all.nl
Cc: brauner@kernel.org,
	cmirabil@redhat.com,
	cyphar@cyphar.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Wed, 27 May 2026 21:31:15 +0300
Message-ID: <20260527183115.2251894-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260525202937.466497-2-jkoolstra@xs4all.nl>
References: <20260525202937.466497-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jori Koolstra <jkoolstra@xs4all.nl>:
> +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> +		const struct inode *dir, umode_t mode, bool create_dir)
> +{
> +	return create_dir ? vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0)
> +			  : vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);

checkpatch says here:
WARNING: Symbolic permissions 'S_IRWXUGO' are not preferred. Consider using octal permissions '0777'.
#4361: FILE: fs/namei.c:4361:
+       return create_dir ? vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0)


-- 
Askar Safin
