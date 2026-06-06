Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5919E819
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780710051; cv=none; b=SOoSWMZgPo4diRuVUBehfutvI1tlGfM3W8EbUZQxfkyBXbBdvcRGG2ePcB/nq5AI60zabir7aKL13lRXrDTmBAAK3h7dF10JkMF86eMQ9yB+k6f6V8TTFBpEcYtzSaI0upQSqFHu4cr6VBU3l64aD7dXGgisocc9JTc34zxfs2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780710051; c=relaxed/simple;
	bh=SiWoX+kFye0akJTITABNYkmH5LtQV4jIKrChbmKJF10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9MGoPGGpEu+WOaQwuNa/RZd62GZEFwXdR3n9ZaUkHDpld+FR03e1294h45hPgsecjOU2xX27QFKrvJ8CM4gnuq5x7Ere8OtiWL08pmILHaoQnz2kbhzVJT+T+mB162T1y8TR65rW123selEPU+TfAn6OD9ELV3E6zR+Fhq2srk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljz08fAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljz08fAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDF51F00898
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 01:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780710051;
	bh=IJR2AhybfGKxsZi4xTyLmSYowvCuHNOaCNVbrfmHOCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ljz08fADH9JD2e/6mLt90PNsvjBqwoAXNPsB582SuQe81cn7crezP7znprT1MAPCh
	 YVwvwcxgTs5ck/KS/QRjHHubFnzzGrVJ30HMBy8Lv38n/zJS0/kFQzEMw7qindk/XQ
	 L26MoYR9iXXyoEZzcMRiLb5D8hEvqMkIoB4iEu/7peumt9GYPWAZ1VVEuXMEFc+jL6
	 E0vMGX9+c3M/rRV7aCr/0lj9ADbNy0UFrzcA7kNSfmrsToR1doOPkp0vMzfo6+CL9O
	 kBld2rXMUPrCC8LWaQXAbIvn5ldx6C8mFZz3/7RrYZaZ8VewCa9p/2pLWhRQ1/GUan
	 2WhfJmUivqgKg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68c1630159bso2823712a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 18:40:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/gtMRlfb+j6LYRoOpWKISgK9XCkJLwDjAPPcJqZhpHXgRFt+aR5DW5x/N8zFnUrvz0Fw72ETkP2PEjzo1y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1Q9j3fvIxAajmKXXohr213xp/08VOgOUiTEygV48vHBD9sGp
	cnpfZtEOEnwpy0xn5Nw5pfC9GUo9luILUmecDg4R3IpOTuCAv/46RtzQVpaL5MhUebvvAO/RKLZ
	5l/CRo44X7ilNzePQrfE8P87LejcwJA0=
X-Received: by 2002:a17:907:3dac:b0:bef:36f3:7263 with SMTP id
 a640c23a62f3a-bf37086aecfmr330367766b.17.1780710049595; Fri, 05 Jun 2026
 18:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530143514.3083601-1-charsyam@gmail.com> <20260530143514.3083601-7-charsyam@gmail.com>
In-Reply-To: <20260530143514.3083601-7-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 6 Jun 2026 10:40:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-QGbVAE6R0p8obu8VeL3Xe3V014+LRGJkfOLO8tmwbsQ@mail.gmail.com>
X-Gm-Features: AVVi8Cd_6HTFXitCZ71dOp3mM1rU2SMSYVNNdZGa0KkJ-WgeggFBnKi-DWq7bHs
Message-ID: <CAKYAXd-QGbVAE6R0p8obu8VeL3Xe3V014+LRGJkfOLO8tmwbsQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] ntfs: validate resident index root values on lookup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +static bool ntfs_index_root_attr_value_is_valid(const u8 *value, const u32 value_length)
> +{
> +       const struct index_root *ir;
> +       u32 index_size;
> +       u32 entries_offset;
> +       u32 index_length;
> +       u32 allocated_size;
> +
> +       ir = (const struct index_root *)value;
> +       index_size = value_length - offsetof(struct index_root, index);
> +       entries_offset = le32_to_cpu(ir->index.entries_offset);
> +       index_length = le32_to_cpu(ir->index.index_length);
> +       allocated_size = le32_to_cpu(ir->index.allocated_size);
> +
> +       if ((entries_offset | index_length | allocated_size) & 7 ||
> +           entries_offset < sizeof(struct index_header) ||
> +           entries_offset > index_length ||
> +           index_length > allocated_size ||
> +           allocated_size > index_size ||
If ntfs driver does not use the allocated_size field of index root,
how about removing the allocated_size checks ?
we can also skip the shrink/grow ordering adjustment in
ntfs_ir_truncate() in your 0005 patch.

> +           index_length - entries_offset < sizeof(struct index_entry_header))
> +               return false;
> +
> +       return true;
> +}
> +
