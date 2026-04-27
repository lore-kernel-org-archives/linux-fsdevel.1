Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766638911B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275799; cv=pass; b=NQctbWV1YM1s/jTmMHqcQuWq3DTQh9FpKm4t3JY94/BWQ1Jro7thx5TFle+JBdYHQOlkiBxnejbk+5NIXzA02qpyqj/wiR2XJTXG3C/j1gCXfVNzr8ooge4MmFB6c9+j/9pdAyD1PW326RJbDDHTGcxxd4IfQ7sOmwKsdpzPapo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275799; c=relaxed/simple;
	bh=WmMNIGbAGBnWZSMlQH2IaOr5hvZoDWPa/zqdW8jKm/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUz2IkMogKy9kX7qw4T0pjawlgVSYFp742pM7nF4vT7AS0sBrRTexlBv/WBKgWDLxesf7KTfP64SHzh/8ikVHRstZ584IF4g+IWEVcPyuIlZXnexVVmemcnqwaaHRz6uTMYEc7VhC2xnwS3v7Ytytwn13R/TMeGs7rohn5NfHqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/FA44Bb; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/FA44Bb"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so12086464a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 00:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777275796; cv=none;
        d=google.com; s=arc-20240605;
        b=VgJASoxAW8hO1uStgmQxtpQkEfVzP3I0eS42b58/ltE8/H4lxkZiP34Km7V4BtF9tW
         Sz2HXs4thUhHJLwYItbDsAWXKTV1rLmZ6vtLqnSHVnjiXSTFvpZZYRm+ZFsYiMRn45YX
         fNHF2SY5cIGtbyphBHJjEGCnJASR3xrC3WJizDoh6obhdTZY+v0byTzSmgrc9VTuWrMv
         j2zP5HQM/bTT/33Amss7WWLfW9tCU7RxHCb05faeUUDVgHO0dwRS2BW1ZFwakx7Qps1i
         wuYsLLq/3HBZvvyMJ2zrDfQMTUBSBP7CCBAGvW+9PVzcMY9uafildE4MdHU0HTxdosWL
         3jEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WmMNIGbAGBnWZSMlQH2IaOr5hvZoDWPa/zqdW8jKm/U=;
        fh=poysh0Op7kYyUSZAvUUxeGzVtiV5J+9TxDnOp4FkldM=;
        b=gp7LYismHd1oq1SP/gWI7ZTEcaG074h+K3B6A3s7KCmn76cch9cYL3bsEs5StoG6US
         aDjREyYpyqgURiCk3kVCmiISLl7LcBxYDVxW03WaEwzA0ybCgo3aQTxwvLsPfMf1x+7T
         07VIQ6sIx40c6V0TxiekIL++RnfachHBUK/OMyp8bQtiZkTv2HhsMTVcA41hQE4kmP9o
         4Yv2QOAmjSUtfl4lOPdMiRwygTz1oOxRJAgWLGFPxBiVQe1v/fkuISu+NknICSm+oET7
         lXWiW5azC6uxuT4hNjwTf+e2s2TdCq9UNMpCfY5fKYfE3JP1AVxWaRZbNabMvEcO/IDE
         gR0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777275796; x=1777880596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmMNIGbAGBnWZSMlQH2IaOr5hvZoDWPa/zqdW8jKm/U=;
        b=a/FA44BbzZXxxbedD8kE5+H1vrImlqqwN3YbeQOMdARXbVawR2vWZ5mOHYsA0YlO6v
         +mNHBShRUXyetKieaB97logJ3fHpKQfperZrl3A1YBRmfKG7kWwRx+OyWr2e4qHevHdI
         FkSbpfYlqPq1NF1ZGronloT46QL3AE0W1eJi35NbAOuLa93pZfVe2V8dNf/QqjdRZws0
         ccmYmpcAf4FGllvW8jDeuJuKAoC7AeJJj4aKFMgI4ZGbnMNhE3AXwvuBO7STe9DrOEVz
         0kGo3j33hKJgLfhPoGH91kHzGdQkBkILo/RhOF74RxQojeHWwmocHhlB52HiIugGKkx1
         ZoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777275796; x=1777880596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WmMNIGbAGBnWZSMlQH2IaOr5hvZoDWPa/zqdW8jKm/U=;
        b=fMPHx+hLc8/Yy3wAYWKFBgD/WKBKr7NJYedEItTwnvxZn2ZbiJxLiKKeHF7bhOPGhX
         XdACTsV7PBgB0aG/zf8k/FYo/ObXsDXq1GfP5/kdAmPTXk9aZ8/aQ3yej7osBVDdC2Xl
         zIYe6+yUwoc1Z+aOLeM7JU7ylCdOrYILxtL0f8M4A9HnrsjFVWfP0G/DZYRnlEWU8n/1
         45AjuObSEvOciNYpzlgT7SqlJbqL4GJ3IeZbzzdEQ68VdPDr1Q8A2Bc4fHfHydiGs+FR
         j0b5290hS1ZnXOr8b5peGFK0fuEY54IZXEdXAm4NnMRCQ8T7+k716ZdfE0oip4ufhPVc
         HXtA==
X-Forwarded-Encrypted: i=1; AFNElJ86+g/B2UZQJ2fI7alXfZY1M4njRp4IpEY2ghojvICQBk06OPw4OdDA4no0s0Wzrz6XPwNtgMjJ1xRlPr0t@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFqiASL6Gy26LWejMe5uUoUd8UxnvhL9P6tUsuXgYOG0xR7Nc
	9EnGRsXBp9hSYJe9fMfK1YmCnAaBty1JFcVj26tbj8h4Q9QTQFwmw1JphMjwDYuml5cIpnuGiC7
	hvxYkDuK1F1HzT8DqJuJNFhmIgGHUnRo=
X-Gm-Gg: AeBDietNZVFtJj6MfJ0wrO+PKhFS5sZblDHtMZKD9csYc2XACsna3nUsSQ9ls3nY+Y5
	4FsiQMiOgHkq/cvvJ7Hl9VM2uKv6cQaxblkzngFO0c9wAkF9X04o+WfU75IEN0JVaTPz2O04uIq
	Xe+LKlIRB2w66FMvtRymnq7pU5tAAeDwYJWbPnYGZVVgsvIOpn7Tw/+xw+qsezIfogyCvoNqM+c
	dcrYx8HyntDcL1j7HO/Qbiqkp1T0IM2e8Zrs2bJ7Tov796ve8jYmtJLbel5AIRH6XEUYwzp22+6
	9rHHyexf3QQsVf7ycjRbtoo8ZN3aM0GLyNoNd82dSaOzjwnog9lY
X-Received: by 2002:a17:907:c30f:b0:b9c:bc70:e928 with SMTP id
 a640c23a62f3a-ba41a91d717mr2121879166b.25.1777275795629; Mon, 27 Apr 2026
 00:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-8-neilb@ownmail.net>
In-Reply-To: <20260427040517.828226-8-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Apr 2026 09:43:04 +0200
X-Gm-Features: AVHnY4Li24Tmq3-41JYR95SCf6Z2AFdg2a4cjT7d8-aaRtTKWrSVG2trUoxa1eg
Message-ID: <CAOQ4uxi8rqkbhK4=8N1ncfU1m6bjdHLbinSf=j3k0oVEaSa-wA@mail.gmail.com>
Subject: Re: [PATCH v3 07/19] VFS: Add LOOKUP_SHARED flag.
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 6:06=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Some ->lookup handlers will need to drop and retake the parent lock, so
> they can safely use d_alloc_parallel().
>
> ->lookup can be called with the parent lock either exclusive or shared.
>
> A new flag, LOOKUP_SHARED, tells ->lookup how the parent is locked.
>
> This is rather ugly, but will be gone soon after we move
> d_alloc_parallel() out of the directory lock as ->lookup() will *always*
> called with a shared lock on the parent.

Neil,

Forgive me for being skeptical about the *always* part.

How long ago did we add ->iterate_shared()?

It's true that Linus eventually got rid of ->iterate(), but we did not
get rid of the assumption that iterate_shared() might be upgraded
to exclusive lock.

The obvious reason is that *someone* needs to do this work for
old filesystems, which are also hard to test and nobody wants to
touch them.

I have nothing against this patch, but I think it is more realistic
to state that LOOKUP_SHARED is here to stay, so if you think it
is too ugly, maybe there is something to be done about it.
Personally, I do not see the ugliness though.

Am I misjudging the situation of shared lookup wrt old filesystems?

Thanks,
Amir.
