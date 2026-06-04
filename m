Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221551A9F9F;
	Thu,  4 Jun 2026 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568269; cv=none; b=EC2BqKDRj04008FrkTKM1G99NQGfix8g5shb6xRJo+rEb+E+I+zwv0+Iu6Eil7fjIr4cKSNppJ1SSKOdoRkO/Ot8guLd0mxrx6pXJr4qb+R0AJypEE+Sw7/sCxMmOsyDq5HRXTPbr0+GqoIuftsBkxxCn55NewV+KseVEAG0478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568269; c=relaxed/simple;
	bh=H3FPW24X3zlDpiZIK2TAWDlQeWlDbZS5WfTjTZDSME8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omBKyAoxP1iQR4CBY9MyUGK0MFOomIGrCWX7RwL0dqt4TVdwtV/JVCRQLeWolh5UGEGH9l0pojyN/1qwGQseAAIINRDCpzVy9lcGtLxvXfSJTs68GryRZaE85+P6yZIv1WnVcoGfq7rjbrzmSsrM1HfVlAObNtWExsN4hye/S2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I53qAd/q; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I53qAd/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780568262; x=1780827462;
	bh=Vc21Ap6crSXxT7y7bF9f92EbYAhOW76rAEBjgxkDio4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I53qAd/qim10NF8wIYqutWe0CHsviE7gTjiy6LxtuZQA4fvrT24J+Kkm94H7HRrxK
	 qF0Txs/tEAThCuaY5bDGuKQpq65ABC/ttjtB5azXjgJ8ZareywnM7XwMgQB4GZ9sbF
	 11IXJniCInhHGZ1HpcfyLtAf3K/rNH2R4mYEwHUDIfmuvCKwgh2ch3/qcC+vvZQD61
	 LU5HwR3kFX/einPSzdC3aG9R3Z0Hb1d3N7g6odYQdfSFmt/0ZPdq5pAXzUS7nuQDqq
	 Llz8QirY/FFDCoIxk3P+b3CPhuuGK9aimaN1cjdFDJKRtsKusY/GbUpcjfe+qs++88
	 ZYsseR2TQ1CRw==
Date: Thu, 04 Jun 2026 10:17:37 +0000
To: Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, DaeMyung Kang <charsyam@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: validate $FILE_NAME length before converting the name
Message-ID: <20260604101733.132709-1-hexlabsecurity@proton.me>
In-Reply-To: <CANFS6bYtjMEtu_pn=XzrRd1Vyof00T75G3UEB9vLSy9Wqz2v2w@mail.gmail.com>
References: <20260604053921.100409-1-hexlabsecurity@proton.me> <CANFS6bYtjMEtu_pn=XzrRd1Vyof00T75G3UEB9vLSy9Wqz2v2w@mail.gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 7a6933492a00fd3dba97324ae07bd1f546cc49fd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Hyunchul,

> There is already a patch that validates this in ntfs_attr_lookup().
> https://lore.kernel.org/all/20260530143514.3083601-2-charsyam@gmail.com

Right -- DaeMyung Kang's "[PATCH v4 1/6] ntfs: validate attribute values on
lookup" already rejects a $FILE_NAME whose file_name_length overruns the
resident value_length (ntfs_file_name_attr_value_is_valid()), and does it i=
n
ntfs_attr_lookup() so every caller is covered, not just
ntfs_is_extended_system_file().  That subsumes this patch -- please drop it=
.
I'll leave the fs/ntfs attribute-value hardening to that series.

Bryam

