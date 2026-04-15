Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2723A5456
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259457; cv=pass; b=asb8ZJNaELArjQilcfd4+u/8kiG0Q3dZJp3qYflndF2O/caI7aIyJaFm75MhJoOox+fYUN161n1q/RjHZrNyvGVzQI0JtMpYdkzxVSwwFw8pRO0pPWPCURIWFZcp1q8byCGdLHjzhc5TBVJaSS4G7+Ehr+zPuVs7qprfMzBQrdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259457; c=relaxed/simple;
	bh=p4Y5Pcu21usvk7w9ipon8j1IaaG9NHtcgi8eCmSKFTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mx63yYgRGTAU5DsCooVt1a6Y92UU/RW4RFVGHeSDUn/QDQIHXOVkli7hq0FQk0fFWrzI41WI2DCw/mYyHjhbrK9XVRzfVpim3mr5B8mMcDkma+xtaSo5honYUiZgvrO50FHKCYEBdIt7gS1LY7a1dJIzq7PFObXV/IYfs7/dMOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTWyuEtC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+Qiyb5U; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTWyuEtC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+Qiyb5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776259455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4Y5Pcu21usvk7w9ipon8j1IaaG9NHtcgi8eCmSKFTQ=;
	b=aTWyuEtC5mextQDBDmK1JdNFO7YSqFizl4vvJrJNFmT6hEP7U03TD0g5uxog6KIeVUtLVY
	Vb6JeSFbLOvbbmi7y8BJAzwZeVlAngezTm7HZ3mgO1dlkRrUqaLk/0Gc1SvCZYn4VBNiI8
	WPcdOlwJyimD+t5abg7L1+Hy3hA++Ko=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-hFV3rK5XNBe-wZjeyLiq5w-1; Wed, 15 Apr 2026 09:24:14 -0400
X-MC-Unique: hFV3rK5XNBe-wZjeyLiq5w-1
X-Mimecast-MFC-AGG-ID: hFV3rK5XNBe-wZjeyLiq5w_1776259453
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9c450065c3so425245366b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 06:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776259453; cv=none;
        d=google.com; s=arc-20240605;
        b=L9WZfdbiYTjhZUvUBmUWxR4DF8gwxnJybjHWX6uefeMQJIuY7KiYm44q99ViDBIm2b
         Y6l8CZy5+c57t3pUzx8GDQD84fUdAWM1g8gJeEjE4Ruzu2fhWigOqsUnOSWxsQFHwJZD
         mCTiEn0YmVCyfoMO8d9Dwj5TXGFFkzLY0o+XWnxZBO65YW87OK3w7UjQD124vrKTOaH6
         M5+BtrlKRqq6ENiciskwLGip3bgqWIPFfsePl4uJwIdyAv74FGiyLbPLvtPO3lxnupiS
         XSmyJQsjE67e8RBL9GuuLtDLIGhxDn7jVxeKv5mu/G21j2GZDC+ZY/INe+0TRkdiHQqk
         01WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p4Y5Pcu21usvk7w9ipon8j1IaaG9NHtcgi8eCmSKFTQ=;
        fh=LIMCR4X6VpbME7v06SeabQiXGQw7/yF9y9Ao/5ygn6U=;
        b=EH/Cf3YMV2Fyb75MmIM0ZOcnZJkcAXhaLea5KWXKoRUZtnR/dwwEPCtEm4B4Lmrd26
         Koso3Nx0MB7e1j8QEUcsxVV4uTxtACUhMvPkjpe1MP7N3tjqiq2e4YlUExvOrZe8r781
         UuIhBSbLIy0hbF3qO+HKkDN354oObqUbVotlTUfPuE5f0cIhC9KFZ920+AcQav0uxSmN
         YgzxRB8bdEYpGRtiD3u3JI0FzES4nEVBpkuz+qQLNmgj0mc+zyIj+InukXBj6hv0lrxg
         mGMZdkyBmfocwMe/0FIDtuti/XS5i81JTMi7yognHUfEC9GmW+YHhzB6bGWYcUyI7cE1
         w94g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776259453; x=1776864253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4Y5Pcu21usvk7w9ipon8j1IaaG9NHtcgi8eCmSKFTQ=;
        b=M+Qiyb5UJfulDAaIUJkWCDV0zGLN6haBWB4QmxF6FWImSPRgQTE6YhAyFoGYAgz7WG
         IaV7ML17hqKbvif1k0xP4XBFY1e+yeEh6Nb+3m8dnKc2gYOsas9+o3XnhZ0FsG5VAgu3
         9JnYiZrHyH+UzuNhcK3+ckHAwacMcgxQcBT2JNO/2xBSYCZQbVpCB0yeTWtyPMcHr7yW
         m77YswxizNGkMXRTBWKAyC3AetoCK9zUf1Sndxz33A0NX3RQAk8Zh+ClO9m6ifktbZTT
         toh3amJUaGLsHjRkqoQJ+qfKt08LRfDScNKGScKpSL5lDxdxCRreVnEWmFqZXP0734Qn
         l6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259453; x=1776864253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4Y5Pcu21usvk7w9ipon8j1IaaG9NHtcgi8eCmSKFTQ=;
        b=dL1Kk4vIjaH+RuLQ5ZA0kdnAddHb84eL3k3/E+tXIki1EiCfhKvMcSHmXB4Pc50A5k
         e7JQHQ94e3anukJOLr5cc23jnps+0iDA4IL3yUu2VE3nQDXZUrsw4/iT2Ylr8OEaMlLH
         l17ujwFnUq61v3EMSJsN08GQZS2U0I7LEChAeJYn6o0yn5EvcEvFGybY3Zp7fPkl/Ry9
         IcM3PP2OBz8YA5b/ksY/gD67X0LhcZtZspshhNlb4usL53QfO7jJJ9/Y9ZNRdoE7UsSa
         ev9HpAzoLG8K5YhvEb+yY7Rnu4ZJwU9GE3PCldomQMU0Ic1QcDKXdhQxL81ugV/Rqf5o
         xfUw==
X-Forwarded-Encrypted: i=1; AFNElJ+1uBNcOKHcj92AW5xVl/15T4W7DlD7tpP6h0l73A9kO9SsnQwJDRMCNOCM9dXYVaPekB1u6m2Mq83sJ6fs@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgzZ55IqXo3FTjoRfpXS1K443BNVXTrUr2qG4vfmHlDU1WJvV
	XbpeQvS7WeJL6Lt7GQkkfW2W0pnx1lmW6Cu0DG3BFPrjoxrLDWp8Nn/G26Y4AC0N1WcF4zkUqwx
	MlS5CZ/1EHC+yA5huBdlxSwkHr4WzcH4orwlEtxlyLllsfMAgzILesdRsAjVH7SvEH/OfZ9zBV6
	HVbR/cXd2kW6AcfjLbGacMDXrxgELaiCk6KWTKMz9OFQ==
X-Gm-Gg: AeBDiet/pihbB25Cw4N+3FV+Q5vatp1PUvWkjuxxaJjOtIlGFfZTmjMytk2xmqyeANw
	WhMYnXpWjAhjU+ZihjUGBlpzc5H+utE2vM7+tr/Kox0yBCcpe0UkbQudO7xpMUb4mj0fottrO+p
	qDXbzq2Npv2Wa0JmwEi+wRCMcK9BP3ipcz2bjbQPLS7FNOEb9hIqImp6TLaZT5FfwaZJSE83wZ5
	b8AtcNxVFj7xVabKjbUZdHVbkCsFNjkgqSowky0A0vjfl4Lww==
X-Received: by 2002:a17:907:3d9e:b0:b9d:ecc5:5981 with SMTP id a640c23a62f3a-b9decc55a4emr591881566b.15.1776259452711;
        Wed, 15 Apr 2026 06:24:12 -0700 (PDT)
X-Received: by 2002:a17:907:3d9e:b0:b9d:ecc5:5981 with SMTP id
 a640c23a62f3a-b9decc55a4emr591878966b.15.1776259452176; Wed, 15 Apr 2026
 06:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415071657.23412-1-ravising@redhat.com> <ad88TluB4FIP3yJV@infradead.org>
In-Reply-To: <ad88TluB4FIP3yJV@infradead.org>
From: Ravi Singh <ravising@redhat.com>
Date: Wed, 15 Apr 2026 18:54:00 +0530
X-Gm-Features: AQROBzCmsDNxQUjb9Ho7c-__m1Cu2xEB0WicLl6xTFgmVY-2qbeWoPJ5NYcxSko
Message-ID: <CAF-d4OvKZOsez5589KUYTjRz05PQHCQ-uRkXu-3iaO3tOjcavA@mail.gmail.com>
Subject: Re: [PATCH] xfs: flush delalloc blocks on ENOSPC when creating symlinks
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	djwong@kernel.org, dchinner@redhat.com, esandeen@redhat.com, cem@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 12:51=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Wed, Apr 15, 2026 at 07:16:57AM +0000, Ravi Singh wrote:
> > When creating symlinks on a nearly-full XFS filesystem,
> > xfs_symlink() fails with ENOSPC even though space could be
> > reclaimed from speculative preallocations. xfs_create() already
> > handles this by flushing outstanding delalloc blocks via
> > xfs_flush_inodes() and retrying the transaction allocation, but
> > xfs_symlink() returns the error immediately.
> >
> > Add the same ENOSPC flush+retry logic to xfs_symlink() so that
> > symlink creation behaves consistently with file creation.
>
> While we're at it - do we also want it for tempfiles and scrub?
> i.e., should we move this logic into xfs_trans_alloc_icreate,
> similar to the quota logic?
>
tmpfiles and scrub tempfiles are created without
directory entries, so they don't need a new directory block
allocation and don't hit this ENOSPC path.

As for moving the logic into xfs_trans_alloc_icreate(),
xfs_flush_inodes() is a heavier operation (sync_inodes_sb).
Pushing it down into xfs_trans_alloc_icreate() would make every
caller pay for that flush, including paths that don't need it.

I think keeping it in the callers that actually need it
(xfs_create and xfs_symlink) is the right scope.

