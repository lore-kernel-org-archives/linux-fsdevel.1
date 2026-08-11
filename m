Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447C40F738
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435798; cv=pass; b=WOskqyMbw5i/iqp6unVuuzdE/iKnyCpo6K/fC6J6BN9F8WpLC3dTnQWFL3S05fPfVhFhlXSFYObUzOEKM9eJVTnL/RRuP9l8qrbF4OOoWkw6TrJFBvvwYbslhSBaxKYNplVBAgWMAegLFIXHY4LL+mvNf2whSIsISX/49UZUJ4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435798; c=relaxed/simple;
	bh=lnwTgcWmbcIBg2Qgc8rEXw/pFK3g8h7NAtGPGlBFVOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJNiXAXJi/oEf5g1oqXvDpkSX7Zp1If0ySxXPlvSDmUex/OHzZKMZb8WXnTmFwC9qpT4sa0F5p4ttJ1Dl7Wbp/4X8lqE9d6F7B7MUZAMx4Mmcfw+Zrn2CpC0Hk/fBFtu8lLmVgERF8HN5O6McmCfp6lOiTOHsqSA6GFcZ4yTLpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HVVyr6Fu; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HVVyr6Fu"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so270923266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 01:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786435794; cv=none;
        d=google.com; s=arc-20260327;
        b=RZWVEu8IkKsrU/jugZ1LtE0iRDHq1VFPQNkv/vfYdaqt778F3EIfEKLT0KiZJ955FD
         XY6DsTaE9lKerVXRXhhcCSEIeyoEZmeVACtsH/tiIhAIOrhaQz3rFvgErVLzrp5hvOvl
         Xbf3vsGHv0UsKRVzTneUoEEYLBkWTMNfP9o27rpWcUMk4NLpk/9ZORMod18xKEpDK1ur
         jyhwYVH6vH7pRuHqbjWr8Y3bCgIH1ALBZcWtIq7mqGoPzZKewbZOwwP6jKCfwhCsdBdI
         PUWAL1MuKVLUwp2juydSY6X7HJD4IDgKNftHxIn8yanMseQHDYJjp33ZqTmOqlzLPfaG
         eYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T54VimS/CucgMjNGFDBKP4gUuwtmX/EU6Le6wVxQiWU=;
        fh=r2zOp+HROPgmj2Qcw6LsbZWwPNlq3vUYMS2pLHa37Hk=;
        b=baNK5ezxwokf/J6Iv6ljLV4rA3/HnlX1CUuKwIZsGHFTJe1EcqMNHvWww7XXfKFmKd
         c6tksgJubOyUhdShN7t13Q3pwoniUaZnXA1em6oUaDY2kXfYGtT5PZ+eP3T2Ucmm6+SJ
         ywW/JwuY+PvUGImiYl1Jj4GUR7/aqAmwR5ZJv9PBEIXBWMj2IrEV20e2/+IGdElYGOnp
         Gau5QGBMlBXc8u83luJwv6JhXhtqR+AwSjcC5Yt/xo20CgzBlHWnkaJP68D7687BHuaP
         ZrkyECM4iahs6XypQh5Wb5Oom1gupIZ6q5FQb+cnUJyz3w0IIBjrRwD9N1KxfLtMfFYW
         SaWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786435794; x=1787040594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T54VimS/CucgMjNGFDBKP4gUuwtmX/EU6Le6wVxQiWU=;
        b=HVVyr6Fu35rSQCWNvO+e0CSUWWlj3IH75HD05i3776Mdqo5gcPiIxqAdPYQQflF8+O
         Kcs+ibeKXHFbqeKiY6jnnJLCjNhRS+92ocu4RDeSi4lskOpHpqdsMoRE1lf1Oyr/3LPj
         9cHAbHMu+WN7LYpKBaiyInit8zblzd/B6Xb6HY8bd/MeT1jrLToNogCVeoLlC9SkVUUL
         Xdi1EvRLrJU3K+JUX0CQQnfWlESexmkhGEp/X0YljyvVdArnLbL75Q6bpucrMswU5BPx
         t+pmNBrDMddoAkyMxNyS1+bDLqDz/J49FJNo+B3JejV4N9GNtYB6YBGoRDKJeVH2Kgi/
         PoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435794; x=1787040594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T54VimS/CucgMjNGFDBKP4gUuwtmX/EU6Le6wVxQiWU=;
        b=h2AOVDPaKmb1pCzsbuMDlaiXFaPtuYZ4uLXyOeZst+FiK1GJiUsSUuXOfUsDLiCE3s
         +9v1sV54mRoA5/cvnAYOUu0dtIAOF6Nc03+hw+W4QW4ikWrIH+xHKt6oP0E6u/iZVDMd
         J3krBMRdLcPZbhEWfuSpdn71cAjfOeulybn8CrwOJStvbcq0WewhBDTzdgu1yAi8pW7K
         Hn8xIb83hHEFq3uk9vy9t7+HgGtMHWWp4U2HyqBcotkGBAUm3qgJ8PtOEApPEBdxRQAM
         6hSdcZlecJIJHpdk+q9jdqtXOu12ooaCtqVoOY6k3SiVxzMCZnNTI4NAFHU9D99X9xkg
         0N0g==
X-Forwarded-Encrypted: i=1; AHgh+Ro2UCG6thU3IFL3afVj0f83pl2BdvJS38qntL+BHWFKQfuye5v3IBz2mooU9JX/RziF/Fi5+lOlzB1g95bF@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJWdpzskktHEFX0TjDhJFJ1GO3Jxao+dEXrPX+jCqLu3JMkAH
	ORTtppVeCaKIg51lHpeWFaOHZIi62Em4d5bndiivg59P0sWyjELSeK5CrC+fBSqgworq9JovfMc
	EUGBNmzpkNU8E8uMLfWDZdVZSz8XxeyQxwbqAeLlflw==
X-Gm-Gg: AR+sD13xPjeeSf6qt8oDyLsGYEoOssJt1rhpzsJIsyy64++/4YGPFzZCaWQ5n++aqua
	Qq9T4+v/QRKDJiIlh8BwYzknnHyk1MSgpir3OBtAJxEti9Do7iQBCVCOvrhy3Gn9PO6+O/UpbuR
	nFTDf9g5C1pOgfSi0JRonxEuGXUvO8SVHMPb6vJum+65pHj6b570Q0JYglbU04iYgZaTw6sjFJO
	EAtnTYKC5ntD01ENCd1AUJvCN3EhUHW6EC4O/dj7DnrmWHp2QEVUDPDVOflCdkPWLslvpYgfJjb
	HHru22bntA3CBytH8z88J/FPX4Cs1HdPTjMI2w3KF9R6e1YuzxvkaNK3JK8PCHaD4BmBpjmba54
	s04o9OGK6Zw==
X-Received: by 2002:a17:907:c14:b0:c20:83b1:396c with SMTP id
 a640c23a62f3a-c20e622569dmr56516466b.17.1786435794433; Tue, 11 Aug 2026
 01:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727130716.1099906-1-dhowells@redhat.com> <20260727130716.1099906-2-dhowells@redhat.com>
In-Reply-To: <20260727130716.1099906-2-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 11 Aug 2026 10:09:43 +0200
X-Gm-Features: AUfX_mwxuJUD9QwttfMG68Fi2B7SoG82gh9YWa1e7DmPzlVYbeVeeqOw4OhyccU
Message-ID: <CAKPOu+_iAa675Axx94Z15X12EOatM-FBCiG3UGN3zMT65rgNwQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] netfs: clear PG_private_2 on copy-to-cache append failure
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yichong Chen <chenyichong@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:59=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>         /* Attach the folio to the rolling buffer. */
>         if (rolling_buffer_append(&creq->buffer, folio, 0) < 0) {
> +               folio_end_private_2(folio);
>                 clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
>                 return;
>         }

David, I submitted the same patch 4 months ago already, why didn't you
merge that?
https://lore.kernel.org/netfs/20260330105548.1371339-1-max.kellermann@ionos=
.com/

The "Fixes" tag in Yuchon Chen's patch is incorrect. Commit
e2d46f2ec332 ("netfs: Change the read result collector to only use one
work item") does not introduce the bug. The bug has existed ever since
netfs_pgpriv2_copy_folio() was initially added by commit ee4cdf7ba857
("netfs: Speed up buffered reading"), as my older patch states in its
"Fixes" tag.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
