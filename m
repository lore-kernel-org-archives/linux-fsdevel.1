Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769130AABE
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883482; cv=none; b=TlQXoNz34zVJklP46ZEsSnZMkxIKdXq1mVeuDp2CT2UwZA+0qLy2/k198eWmqiGAXJEZtusSeuMEeeheuMcptsNb2zbHUjo46OtOPpXIIQSaA6RmS6vwj+rAZL/DPxrDD83FfgeTaTMTMCNABdzvlHmj8AhOxl5BcRnsdnPBK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883482; c=relaxed/simple;
	bh=ZWu4ZwGqaNojQSoCOt11x8Gj2+g368Siu0Nfi2tBEjI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjnEUODrvKUBuOiNB8NMNDtRGxYCQiL77iieQ0CtXG5WVK60PXCqLz7Fm+gHcXhitoCqmtfFhTKS3NFRLZI9HM8t7s+z9UrcP6ot2OQyKAXHcbTzPpETQMNqSxLVWNZM5r6sgk1qILpdYSX9asrt9GcBs26X2tc41/zGgI+3xYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VU4H5wbc; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VU4H5wbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780883472; x=1781142672;
	bh=ZWu4ZwGqaNojQSoCOt11x8Gj2+g368Siu0Nfi2tBEjI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VU4H5wbcHnHLQCAV8aCZnFmtFPbKGurBHb2Yg+By1O4u90LCWNhgQbDhKznKKC6zP
	 BO3ouhuJARDPNDE/VVWGXBnpGa5Uqalp7p8skCby8roJwIr0/mX04vFwOUyzwzIccM
	 IIIesol1i6FzZwogjgMd4y0IO0VvrzpsewMdWeEwjUp/+whXRQ3Zbq2aebfT3PAg3d
	 n8AYw5Ip5BhUoXjH/3J6m2x+e/Y0UQ2GoLbj4FIDfwigIClh5yRBhdDQWhnEPVtS48
	 rOPaiWXvCB/eQui2TV+zk5hjVX0iK+/XvrBuRjGcUET/xzBF6tJ4TjO8OEa9qHFTrw
	 kxax1C0rnKWfg==
Date: Mon, 08 Jun 2026 01:51:07 +0000
To: Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ntfs: bound the attribute-list entry in ntfs_read_inode_mount()
Message-ID: <20260608015102.36271-1-hexlabsecurity@proton.me>
In-Reply-To: <CANFS6bbHSkaPXyJvbs7QbvVKKXzjMvs3thweXYbEvoEKow5=0Q@mail.gmail.com>
References: <20260603175949.11665-1-hexlabsecurity@proton.me> <20260604042912.89893-1-hexlabsecurity@proton.me> <20260604042912.89893-3-hexlabsecurity@proton.me> <CANFS6bbHSkaPXyJvbs7QbvVKKXzjMvs3thweXYbEvoEKow5=0Q@mail.gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 5da2825a57ea747f02cb124ce96477ae7a264e9b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2026 17:44:45 +0900 Hyunchul Lee <hyc.lee@gmail.com> wrote:
> It seems that some of the above conditions can be removed.

Right -- with ntfs_attr_list_entry_is_valid() in place the
"if (!al_entry->length)" check just above the call is redundant. The
validator forces name_offset =3D=3D sizeof(struct attr_list_entry) and
requires name_offset + name_length * sizeof(__le16) <=3D length, so
length =3D=3D 0 is already rejected there (and length must be a multiple of
8, so a valid entry is at least 32 bytes and next_al_entry still
advances -- no zero-length loop).

I'll drop that check in v4. v4 also rebases onto the attribute
value-validation series that was just applied: the
ntfs_external_attr_find() rework there overlaps the change 2/3 makes, so
the series needs to go on top of it.

Bryam

