Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37211514F8
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788005622; cv=none; b=Tv+ZTzjjgZOct7pSDQIFO9FCkYcRUeDwuRNdGdE/+F9ZtvxDpXpYpdqpb+lAoFm+Q4FURfeHsXpjzXvOb+3HkQh3AsQ6q+5bCypHX1fz6rwz2HaE/XBhbEzMwWm30CDYZu/tVyIqLeg4PY4TsnlD7ofjPIDXDa2Beje7+HnEsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788005622; c=relaxed/simple;
	bh=JAONKe6FamLOeWHqWahtkO2yz33T3jhe2IjUwPgMEsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlA54SwkbDar/epk3Fe9sbyqV97CcbuHCHGLAmZx00AT+B47vX4AhTFnvfhcVUvdGX9FSyjQBQy8EVx++ZKx5tkkM0+IjodhuDCsgKl7zsm7p02zukk7+LWL5BWwtJE6tMWFcaekcT11vQEPVihv1aON8hxBLI+DQ3ghbluRoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb9OckwD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb9OckwD"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8548db7428aso1720743b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788005621; x=1788610421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3qpiRKhTPXXV/T2+awybSnvPRBM65XAy0brn5CKaYMA=;
        b=Hb9OckwDnr8wfbcsxCcBabOmKJv6GhFigIg31Itlf92ZBjaW+bkygcdIZUvoSABcxy
         h/d1jnmnlmdmMHqu8ercDmvCfi1HVrdZLGP1XoryGxh9M3wmYT2olHWj6SMROdnNcoxx
         AePdCFLz/u8RGB47ONZ8SL6w86nRxENim4MklUOek7SoApogJE5WjALEVYITlPgRFX9W
         8Wtci3+eZ6yW9/1a2ThdDTNy/yjR2kKkR5lNUI1ttEKDW5meQ5+95FoQu6yC8/NpVlP9
         DL5Mhst4a7EpiVu4v5GQO5oGDzAiCm1h5ivMcMIQPz8l30HLBlM0xknSU/jsQsI6OqsQ
         w8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788005621; x=1788610421;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3qpiRKhTPXXV/T2+awybSnvPRBM65XAy0brn5CKaYMA=;
        b=UJbvceAIy2Vwy9rHLfjd3IJ7y7D6ZzVUk0qRHEyKzVnuO83tkrCVO6v/rXBf5hX2Gl
         H1bmpIdnULACIBc6yf1noJoTVmkAcmOHFVjdoH05Gl4uyXNr1t0nwH1J1VVIt4dWzKJx
         J1qUE99cBBQC+PexCAiPcJ+nc6aA4PGq8gufs5dcizTmzP8KOKiSe8Spoycvky482nNq
         lrwFgObJfq7R+gVjRfISF7HTgdPYHeC1H6gx5CFLhpziD8bAa8gxuhc5ih+PfyEArglh
         OuXNSM2E32HIw8Qm+xcF5O5Qp9vQX8sC6HB6tw9ezUVw+VUsJO4ItwPijWjQPSN6dSYl
         ozEg==
X-Forwarded-Encrypted: i=1; AHgh+Rox84Q4GoSb8U2Kz1IJIjevcL38kzTh5hkBKSb5E+oL5Rgm05JC2OGFJhYq9v6hXgwbFU2U2c2XDCrY+5DJ@vger.kernel.org
X-Gm-Message-State: AFuF++nCXA6fJjbm9WPMxvNJlEi1FOTkM1+MlR6vNPtPIyVrheSiMna6
	ZgZIDj4rkN/r5WS5x1fcGIBXboUFXQCqWJEspz/aTMPT2UT+mFiKSeWQ
X-Gm-Gg: AR+sD10Yu8vAdscyQsNA5dvkMNTzon3hvy80inOQhuys5PvcPZAj9XcqF3VIpDetncA
	hOvytUsrDQ7taAkk/TEQwvhWEsHdXntUWprdjPqhZtrj8l6Z06+54mmJVTpY2E48aDiSt3GT5AB
	r7ja6fWIKjKD2XqAo6tyDel6qZ4NPmOoeauYDbqaY1XZu05F3+BxYFjUHh02l+bn0qF+LJg4w7f
	tWNmctGIomKDUAZiko6/2R7Pb3eEyi3PW9bfTdNXciQOzKbMJlATuYa737bbqZynL8t33UHbYVq
	5vbkeQlUO06yxgSWBsQvBxYGsu7aP09ygua3PCEcXMMo/CWvRRyearP28mSKGTagXpmpS4kRI2x
	kuMbx5YVbwu3b2UJ5U0fXiWsaAfcqrn189kxLxOd8IAecE8YptUVYyzQc/oysiRGoSOePRHMwNx
	BNgWiKwJBO6HHLW4tEdrg4ph5x43PKEVeFJbUzhgo1DTw27FzWgmE07ppxeDwi6IVU93H8VTd3y
	D2cMIBkhh/VJZAeOYH03CD4RPp7CSWIkw==
X-Received: by 2002:a05:6a00:348d:b0:857:7337:5dbb with SMTP id d2e1a72fcca58-85773375f79mr9928458b3a.25.1788005620844;
        Sat, 29 Aug 2026 05:13:40 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569f984f4asm1439527b3a.15.2026.08.29.05.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 05:13:40 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baohua@kernel.org,
	qiwenjie@xiaomi.com
Subject: Re: [PATCH] mm: filemap: tighten dropbehind completion context check
Date: Sat, 29 Aug 2026 20:13:35 +0800
Message-ID: <20260829121335.3491374-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828181035.ce6e23970d37e38b64818f10@linux-foundation.org>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <20260828181035.ce6e23970d37e38b64818f10@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I kept the helper private to avoid an MM dependency on <linux/bio.h>.

After looking further at the mapped-folio case Matthew raised, I think the
better fix is to retain a dropbehind folio once it is mapped.  A mapping
represents a competing cached user, and retaining it avoids the sleeping
unmap path, so filemap no longer needs a stricter context helper; the
existing in_task() guard remains.  I will respin the patch on that basis.
