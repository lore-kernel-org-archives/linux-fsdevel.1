Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B154A689D
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050472; cv=pass; b=spFa3nPGdXazVhIdBgt1Y4MvTjHuBPebss5CcaEQI/PbrErQ7c+JR8+gTV8M0bu9GMuF1eU2mWD849CKOt6UjZGxAs6aScvRXEJcLksXck+sXHsIgTL97nYvR/7u7vFrrdDfd8eP6XBLnsDtz1YrsDdhza9PAxsBohjfs1iWR+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050472; c=relaxed/simple;
	bh=qrhbYvBNv/N0VI8PEYpw8zABc5tgbspPTRKzj2j/IcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiRu1LIuyL5dZ460HVE4EjCRvoVzMElrlBfLjOVctVyMgNfPmbyq2Va2jTFywV7NzSyXrzy7IaGG4RWpo9MJvX9YFOT5V7z/vC3nu0SzR2TXNxeTPYm9DTIX9epU+wzy5p8EcCHrTrMq3mJz3lWzamx371UtKyJCW2hEsPQpb4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP1Cwo5m; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP1Cwo5m"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35ca5244753so316689eec.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 00:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792050468; cv=none;
        d=google.com; s=arc-20260327;
        b=m2G9O/2+51r4szHMJkNRijru0Z7lxYLk0w7NZ+uKQtnqTgi8eNwB0XnvgayxyY0BeL
         WsNPlMPA3uQfFUWG3bq5Wpa8SS+KSnKhVwbcJ7vpnmpbLqkqi3bnMfhizHjmLjon9D3J
         R04Vo8HsmUEr/wH+1ZSfsqRCZ8d3p0aiADc99JbxXOXmFCN6sQg2DD8pc4ddXxrD31zO
         yNACTDjxDGE9cSqhZjTuUoImTLimN7+MRKzne8CgwWVIPWqa/gCHCZmMLU24zr+fWjOx
         CrmwvfsasrMLlMJnQtrA/vWXAOel8qtBtWEZwmTq+KyoTXfZY+Oxo1BMKkpOkde4JOb3
         a6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aZLy1FDhAffyNHLdSNSc3Bq3qLESgLIT723DgtaMR+Q=;
        fh=KFz22vmMpvU8odCi76O9JELaEIa183lXzNPWnJxbJLg=;
        b=Z1EfOHoSO/w2uDfdfu8O77Z61+5Cqe85LJV2ZKGnpreAeXlD+2axbWJ1NoacVzxYV5
         IEuTBLaxQEGK7wNTs+Du1F85MEB8D2Itb9kYV2Ejm9sNyqKk30PApEE63LcbQiWTsDz5
         GiIbBLu4zupJUEHv1DhMa3icIjW4dfYyJt3y/m82cSUiIJ2PXP+OGMAPzbU+5NUum3Lq
         3bbKRtvnkuJu0cyaAqDXlOsCLFQA+vbUP+YlPCTpvqXsNgkbpViIvCvkpHMPjLA77/hf
         UbJ9TCkoI6mynfhVdG9DKDNviWgDBmJ/q3hjhRseYNnSRP+nrmRLeWrBjHl8DNdmgZtl
         5PxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050468; x=1792655268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aZLy1FDhAffyNHLdSNSc3Bq3qLESgLIT723DgtaMR+Q=;
        b=DP1Cwo5m/G00Qr36FrXInztSqahs9iMMaMxcJ/hFcP/20kNJe1kQqR6npnz101hC7q
         rYCdDkfMUQtRBnrzHGBICeicqiUxrC4xZnALWEt9IPH4/3PwfLSPtGtbr3gr7gd3iFBp
         NyF1Cjs7VZki2xIGfCUzMqsaJHX+xtxdg/vlqTehw2ZLOBKx0g9Tq/sgxWija7I2UoJh
         5tzlBmM6Z5MGtPKDl5+PVZltvINZbU6t5noxgKfgjE/cF2Djt7Q/tru3JTmDBljIsY5R
         k9nmP3lcjHHYX3x5OEw/Rh16SPIOpTQEcHrJJRIzvp+H8XrlBpC7KG/Ny0+NgDcohfCI
         nmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050468; x=1792655268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZLy1FDhAffyNHLdSNSc3Bq3qLESgLIT723DgtaMR+Q=;
        b=pxDYeqbtiPN4or9RdKZXmv5OoNf5oWOtOm3ZeBQIytxutILYj3LfKKvCjqEIITMqLH
         0JEl5K+cq7kLmvZ+C5oM9rA3YD4c0sLQSJEUgDAkWo6anZRGtoZD4QWxptm938koPMiZ
         Q4OJGWYj0cxODH7NidcgfVrT7SmI1ujsOUA7KKseD7POCu87h7AvBZVi1etdMAr59PTt
         1+uUznxr4pmWvziZDqE8X0m2KxkZ6gEgfgTThQoWDweqwRsWqj9dlOBklyfE5P6tLe82
         kKTP4QDhTokWqbdcGffStU1vuKi17DBR8coEg4Uizcj+6at0bfyjNVD4vv732QMNdhkT
         hOKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUbOmTSTKt440sIBxwhPoJydfPfsK19QVPnOYIQNY5uEJc3ZpfUjn3xJ2WMtyF8XjJqoGOFCNhaGOv2etK@vger.kernel.org
X-Gm-Message-State: AFq9FYLYQ5H6EVlAHx/NVBz7ZhPBByOkBYXm1Au1MVtpSV1gAhGwNUkf
	Sl3HmbegtROPg5XNpZFa6k1963c2oEc5+M9mPOGn5zb27iLEAwT6wkli3ufaUP1+0Oy7kxzplvx
	zBVBX8DQRljCHeyKeJzh8BkxXx4oF9Co=
X-Gm-Gg: AYBFou14IVyLaWe0hKsu0BNN3IKpczPRXYRA9qDqDUHVZiYVOvdrqg/4Th6SEERNVoI
	swFQVriyWv2XLp6r5mctYZ2yfW//nkTKtxv3AVWN084aTKEJRO36JQXVE9TU/DkZslGaS8yZ3Rc
	TpJvVE7/n0m6mIpXgPUQZZG8CQAQ3EIJoo1XnFKm6FqaOMk+NbTPimdA+u/AcjFy85uAOfbHMv9
	S+qJpSJ4xp+qsyvQ6Hn1K0P2Z6UL7eFIcukCnfhcqgI1kJFCiPEFzSWGaZdozub6r8cxHYaVmrV
	UkiATNVxQ4j3TkD5T7eWbFFFWPr8jw3VCibE50aWldLp9OSqAXhZ3viN2y77Ie6oNB8q9dqg2qZ
	TIhxcK6eUSvb3fc4ea1hlcrZ8ifOS9I2kpy/ZvFZm//7Aao9TtEfJST/D0iI0CfcMUnSFrPD7Mk
	XgrIz7+zGsvOhtWohp5a2Vd9BNn+yUxM+FB8Y8omzeh/mc2YOY93s=
X-Received: by 2002:a05:7300:f3c8:b0:351:7883:bf47 with SMTP id
 5a478bee46e88-3537dc8e9c0mr38650196eec.0.1792050467352; Thu, 15 Oct 2026
 00:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014225811.i.852-kees@kernel.org> <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh> <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
 <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org> <2026101532-fantastic-deafness-e04c@gregkh>
In-Reply-To: <2026101532-fantastic-deafness-e04c@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Oct 2026 09:47:34 +0200
X-Gm-Features: AclHuK8JUch3-LLJNkG2OM0JVExMlV2wP7uKNynE1Z6fAhzs1hBzwjLh_wcCofk
Message-ID: <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct seq_operations
To: Greg KH <greg@kroah.com>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 9:11=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> __must_init might be smaller?

That sounds fine too. I like that it says that something *has* to be
done (like the original name did). Hmm... On the other hand, I guess
"must" could sound like one has to initialize the field "somehow",
i.e. writing:

  struct S s =3D {};

definitely initializes it, yet the compiler would warn. Would
"explicit" hint a bit more at the fact that one has to actually
"write" the field, even if it may have been initialized anyway?

(Of course, if one knows that the attribute only applies to fields,
then it doesn't make much of a difference)

Cheers,
Miguel
