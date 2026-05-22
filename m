Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320321C68F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779409735; cv=none; b=CMTNLHmbOxSQ0jNSXkDM0H8KN9YiRSG/teVYLGAXmsGUPpmvm0j5Iwlp1fZJYogro9P3XYHptgcoFDd8vB6XRsgH23JCBaNOf4Yrs0B2RDYPeh8N2QquVJLoz/zCXrZQqmySW7kTRCh1bK7t5prpiCdfPmqwrbkiesLXjuHbCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779409735; c=relaxed/simple;
	bh=v45xTb8/aStDMBNnUGLg8nAp3pHY61cbT3pW7CEmL08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXO/eYECMRHrKozedOyRYyZ3u+W7NttIywsKZ9SNm2eqm42sj54gD5YJgKxjmD1pATLRN4DTCFUZSxh8TGkLm3ABy/1hyyl1rOS7COmcuPdKTPMzJaC9+fAXtSlouhUBtx25EVRf4R5qIfYsMJeHjOpsHvjMuHqZO1YgqZSxh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QymsBPaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QymsBPaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6101F00A3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 00:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779409734;
	bh=PO84rh97RCtIYlbOKDCozCawo2PCfzOjAE6XlsqxTg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QymsBPaK0KL7Ur8tXOjqALjapep1YuNQ3FQPP0IDTXx+9uSIYbs4F1jN7ICcKmyyK
	 7ST3Uy03Zi+lUaLeLOPpXCm5L0G1gAqN+81yCoeGHbjUtL2PhmhNvonHghF5UzFnJ2
	 OJs6w7Rmm5ICBIqqIjP4DZjsGD8qWRd5mTAEeC0dCugVGvZeU0gv82aL5J7uAPCsVW
	 sDxAMeOCfdtfwdmFHbcP2xggszszSGahpeYuC4htkTM0pSpcA9So0FKvFjnRwasUqL
	 /VmobZLp2ECEXykcn9LGjnvw31xe7hRVo05urFKZEm6E+H7gDkGWVp2OoF0QfLhv/o
	 mEyTJ4y26MCdw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bcc9fdc959cso1257186366b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:28:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ80RBrI1ERKpco/5w6glCmPmGZ6Q+WZ3SItyO3llmfaHc7TwIg4f5itfYR39OvfQL6y/5h4gNuo1kcaSxwI@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8wcehWyGMxRzFiEAvMGjdF9FRk2IIKQU+RlAv0TPcCebwM+/
	R146OIPnaHdyvvth2nWYGb39p9znmp6S2f/BAJ+96yISwy9bGDKAJ48ma7F9NVFitAeLcv9Ah3o
	ciSlj/itR3IRB2GAZtXYxdzjZHFqkIys=
X-Received: by 2002:a17:906:9f84:b0:bdb:4d42:e7cb with SMTP id
 a640c23a62f3a-bdd22939697mr76575966b.3.1779409732716; Thu, 21 May 2026
 17:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260521101751.591345-1-charsyam@gmail.com>
 <20260521101751.591345-3-charsyam@gmail.com> <CANFS6bYVMzKP2uBV=-XMJ4JHyoBNfzqHDAteZ_8gj4t_C3e7xg@mail.gmail.com>
In-Reply-To: <CANFS6bYVMzKP2uBV=-XMJ4JHyoBNfzqHDAteZ_8gj4t_C3e7xg@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 22 May 2026 09:28:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8QvChDOkXobpo+1iA4TW9jpLW1sCw8zOFaqS2UsFWLkg@mail.gmail.com>
X-Gm-Features: AVHnY4JVevqDW_ij-wxoQSEy_N9WbLthRP26odQByYlcIKAegfNZdoDJ8vPnGZU
Message-ID: <CAKYAXd8QvChDOkXobpo+1iA4TW9jpLW1sCw8zOFaqS2UsFWLkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ntfs: avoid heap allocation for free-cluster
 readahead state
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: DaeMyung Kang <charsyam@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >          * Convert the number of bits into bytes rounded up, then convert into
> > @@ -1985,7 +1981,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
> >                  * Get folio from page cache, getting it from backing store
> >                  * if necessary, and increment the use count.
> >                  */
> > -               folio = ntfs_get_locked_folio(mapping, index, max_index, ra);
> > +               folio = ntfs_get_locked_folio(mapping, index, max_index, &ra);
>
> This line modifies the __get_nr_free_mft_records function, not the
> get_nr_free_clusters function.
> Therefore the patch needs to be rebased on ntfs-next branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git.
We can change__get_nr_free_mft_records() in the same way as
get_nr_free_clusters().
