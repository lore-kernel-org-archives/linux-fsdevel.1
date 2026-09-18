Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC14F3EA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738101; cv=none; b=dw0364ulh9/CD1OcE0kg2O1YeI1oGfOT/Ak2Su9UKTVEo7WvHALn/rsp39r60WAzZ836kD5jFQMacKZZJIUTGFbXPvfyqeH8wxAe1xh8IpV+Hyh6bCikJKdtibP/WRqxxB34rdT3OyoQEnfoMqPxVubZvJ419GFE4ntIM9mv3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738101; c=relaxed/simple;
	bh=zIvzoRp4EqaaXbBaAXZ0LdKRD2UHE9DJZN9NC6iw0vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du1XHTENfF+e63aB4HOSkN66OZRGEVTz3jvqV5vVMVESx78c0J7fmivlR/ZgkiGqH/nultFZwQ4CVb+oc9jjJgk8/1lm3vQ5Ol53rASKk0/A6Y+mL5HuXgBLtveLAdba4Ni+RGaoB53iqlonBZL40VgES/7I76IvBvAAitH0qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWuZQxw/; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWuZQxw/"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485ac898fa4so640211f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789738098; x=1790342898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zIvzoRp4EqaaXbBaAXZ0LdKRD2UHE9DJZN9NC6iw0vU=;
        b=KWuZQxw/I3lqzg9qw7ZjQiGz/Z24MK3auBi+URcDsAqMC1JcguPlshPYLhqPAife6l
         nM5UEGslRvNHPw97JNPJ+qdvY7KP3lVQ+ajbCDMNS8xvX6zrxMjZ5AT3wo+t7kSrJItQ
         AtQeAvg9oyUxiWBloXmYKbEm332Btg4CSjtlcUDpYjkb3OWMLJXkSWjAV+//rcWPV9U1
         /S7Sx+16EAozQAWxMSwwndPfpX1iYEuIUrn6B0ZhgYLVcYidhyESJWgSEkgHXxzY+yT/
         e7JhbG4iprer6Czh/tBACxTaiEqefU8w9b7HuKaPLKfGYw17XLrt8fKZxkXnBSGjS26b
         2T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789738098; x=1790342898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zIvzoRp4EqaaXbBaAXZ0LdKRD2UHE9DJZN9NC6iw0vU=;
        b=ud4LUOr+BiRqjN/UCoDHVjc2xDSK51h/g+r9ikWPLPoAK4C4l/Pqmj9QBjUgeKDY3n
         a2CU5nSOh7En6Flkb/f5NEiYxRr9IfQjDlZ3hOmrmTmnnOyt6o5wS628mKmNRi6u/u6X
         1tgHoWFydY0exzh+FeR2dNN9u0d1tKDPCZ+OzYWv2OMHlZXJsYbNOM+YYDKt2w6kxwka
         1AhQZLC7LU/aFEwtSv3ZFV8Xo/J1zCV+MCJI4CaGkxQM+d1KqoRM2U1kPzWRiATMxVFY
         JLFq1X0U1OcVQpSt1OKe+Lo1YZO29reXcwxAOcsWDVHhLAp/psbvnF8CxtJgsXWUoXER
         pjAA==
X-Forwarded-Encrypted: i=1; AKwUvBygj4r7GhzdutKIW+bLgdfUmPoqGr4oSfSBEM9oPu5RwQlh9hitEg8NOkYvWAEId6ZjUB3YkreXEMRmu+1H@vger.kernel.org
X-Gm-Message-State: AFuF++mg/xYXnnBgTO+7bfI+/FQhuDLzSMQ+c0Z8efUNOj23eO4sqK09
	891Toz9jijhgpeG6JD8ue0n6q03498mgkXj6vzGlegqNPX7Pagd0Viva
X-Gm-Gg: AYBFou170m8fpFTNlYMY44bkuXht/TvACMg48UNfWzuh90DCZK9PLEGEBP3bYxBNnBl
	lF1g8qBducxLTbM9+qwx5u256+Eqi1ABxmUSKK7Ld6SdoB7iErvkkQ/UePSXzGpzxNalf1uQeGV
	zCbZXb0KGZwYEz+FwjKCFVCEExla5Isb4WAOTsJkr8GMTGv6AinHmEGe52YvEcrBiS/7J/O/fZb
	GMpub4ttw7kRADWxABtf54iI2s5on/iLw3Z0tJERDt2pjs8TqAnajU6ZyOVwpD+eNChWEJegbdH
	GIANHjkOpSeQPn030Dl5fq9gm4gm744A/qVb/YXztXPf0sAPY6S8JWaTJ4wpVGnOpjJxL3hCHe+
	Uqrg+n7HOZ7mJAFFyIHDivmv7YbLgU2YBSn8pSgJwtONS6ejO0uMh6B8UcsuEcwBUBpQSvsWtLG
	3+PIBvQtbZkkjadrMPv5g8kfYc2PF6EDrA8CYcFhZreZBQm7+1rwYoS1JYDJoWjCaY4MgG6n7EP
	ACFggYVpJYCyBzOBAochCKYDw==
X-Received: by 2002:a05:600c:1f8f:b0:49e:8354:26fb with SMTP id 5b1f17b1804b1-49fc574c729mr35408655e9.32.1789738097326;
        Fri, 18 Sep 2026 06:28:17 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc58a1176sm40807795e9.2.2026.09.18.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:28:16 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next v8 1/5] mm: Add copy_remote_mm_str()
Date: Fri, 18 Sep 2026 16:27:54 +0300
Message-ID: <20260918132754.43435-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0b276f0a-39b7-46ae-b72f-6ba92f65380f@kernel.org>
References: <0b276f0a-39b7-46ae-b72f-6ba92f65380f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Two tabs please. (I thought I commented on that already)

Sorry, I have missed some cases. It shoud be good now in v9 [1].

[1] https://lore.kernel.org/bpf/20260918131757.42802-1-tasos.papagiannnis@gmail.com/
