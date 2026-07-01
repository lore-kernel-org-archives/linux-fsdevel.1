Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33EC481FC8
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=64.215.233.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911616; cv=fail; b=pgrLQ/JpNcpkwlnqEd/pypiXzwuCZ/cpLc/DzF2nf8JhOx4L4XBbaHLmT2Tmz7D/Q0iiuUe3qHxcHyyQA/zLRscBzwxNPdVyQg1ruxGzTkSp/futYI5pZsbgoVwehbHQX6FP2YQYi/wzqKPokrboONiVGU8H7vS9dPLwD/Hi9Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911616; c=relaxed/simple;
	bh=+Su+glloGMj6m3MT/GTAQRvVyg6iWg03XfdJupNRwUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5AQjb39yzLRmnsBfO/qOFQ9YzZ+u8N4+CmksAokTLKQudl4JTpcX8aoZzhAtaLtp86ucBmBf8UF8LGM69i1B9Ld9suMXqBQdks+Tjt/5lnRjbkljGCdurd6I+dK8gJwIyYGMLNXS/xSVn9j+f3VOaqj2Ang4kT88d84H5PYtRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=l3sSSbqo; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=W5zubF5K; arc=fail smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="l3sSSbqo";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="W5zubF5K"
Received: from mail-ed1-f70.google.com ([209.85.208.70])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.4)
 	id 1weufv-00000009vuI-0RPY
 	for linux-fsdevel@vger.kernel.org;
 	Wed, 01 Jul 2026 09:08:22 -0400
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69848bef5c7so661346a12.2
         for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 06:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782911302; cv=none;
         d=google.com; s=arc-20260327;
         b=AZEaivIJbyGGw46LipEVRFsMJbBgvyuKWZzsW3dEpDHsa6GWO8RUe6IU0xSoYXDMHF
          ffLjZ8YEi1O/S5eEG/W3pKM9croriEgBoxaEjTmgwdxiE90SPWap5JcxZZY+TkeT/0E3
          S+MpRICjryyPdNVAr2uJdxQ0zN2JjJOw6awMlHz42/IMyc8jx8aFPCalf4UvoecUsaR1
          CJIWjgD9K/L69bNvS9aAK7Cnrgy8JUk2ASPGj1LHWGGS8rp2U4SXfTXsvs4mKtlK6sTr
          zgdJ6592QhpRMNIvVTj4eP7e3NOED4mdjgsVrLju/JMGw0+CgLdfGfYsKpKONMNYzBq0
          jBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:dkim-signature;
         bh=X7e/LeiaosEk7gbcvbS8Q8cNOEviS4SeVXYWmv3QOzI=;
         fh=mauj3nMJnDwWpB4n5zwSrEb67nIO1Cp7x/uvHXTow9E=;
         b=qyIhqNOub0S4trT8KO+g1ZlxkP1gOMEYBjDX7yfi9XQR0yQShoydbV9MGQmFoz5CjO
          8bptUv8K6YmI0PEX/Fdozr1xZ2RHctic/WVRzQLA/fXs/i+tyZjlJ+SUcR7unURhey7K
          +L0IhhdbxlDmSPx0aoZUS9BgxARcVqQfH0ZGi1hAWKcEThK6syrHcrHCLDSE6mLSd7Gh
          YmMRryRmXr13slpijcayD8f5Fd5zi0kPjaMXgwA7LwwPE+d0k4Ab5wqpNKSplWUoVAr0
          aEnefOszla0DyiWsfSOBsFXgq1JXi9WB3IgsGbXRIcUYzPj6zpHhoRcaLjldK+Esbh4+
          QAqw==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1782911302; x=1783516102; darn=vger.kernel.org;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=X7e/LeiaosEk7gbcvbS8Q8cNOEviS4SeVXYWmv3QOzI=;
         b=l3sSSbqotSiXFmYbQgAc6ExfJPqAzujPyy9NuxG0Ql3vITdvPRzz80hgkc7JzrL0IE
          mNv4YOQ0GFnc3zHrb8V9UvJOX1mgnpB+VdkW2Pl4hUQD+rwhHH6rG04bHa2xhGDbDHBM
          SALNy1brOPZjR6g2Qg/WwtelQJ9ionajyfXnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1782911302;
  bh=X7e/LeiaosEk7gbcvbS8Q8cNOEviS4SeVXYWmv3QOzI=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=W5zubF5K5t2VcP6Z5302fsEYdDRnkNqiy5o8YialEgWobGXeN4VD6w2Ae1xHpuHlf
  B2PbPjpE6vDTVU3xSGqpaBa0mYo+SZCiDrcElYpwqLHzwXHMQ26R8VuKuy2HIqlZhx
  sqMvaAIcawdYhAKQh0gmYGlkOPlcCZNdKgWYEex41Vq8mWAApZYibliUfBNXSSYy6h
  Fjg/akLIX3yPxY5vSvlCqj6BxB4Ah9O8FIZZvtwOo+qZ8Iw6QN0AKIQePa9MlqYk35
  DZspSLeMeW3VxBHMfVH7OOY3E5q6Wx7YasN4YVTW1XbFYm8SPlqJR5hdp72ymVW6W1
  SqLHix+cCJCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20251104; t=1782911302; x=1783516102;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
          :to:cc:subject:date:message-id:reply-to;
         bh=X7e/LeiaosEk7gbcvbS8Q8cNOEviS4SeVXYWmv3QOzI=;
         b=FE3HNNlpyBxpGmoRB263xl+pErA+0gfkPcIFk7w50Qb3ytXE6h4EOrNpCV/zGZKzDq
          M/aB6CROap6MvjxxYDjoItyKE7iOyFMmU/68dMhcWcJt7mePL0Ejyml+clGUdLo3prZa
          Svq4e/1GF05nlJlJ7uA7NLJizyEgutgs+TUdCjJYNbsgTHtB4WdUHEscFpMzqdio7bFU
          xLPwCF5qQUMbgGBCLmQ/KJyE0K0Kx8/zsUQOoF9IroiClbfu1XC7vBNfX1ULY0lvwX0T
          YVQAHefuIMmPBSjpC3pnGxVil0jzxiaDnGxF4SPpSjmJrT31+jRolU9OBZP4WY7dinyR
          087w==
X-Forwarded-Encrypted: i=1; AHgh+Ro648xDqQDkUxnG71P4s2qfVtavTLS+W4VXuSZe6g8SUj2/Lauc/3YyTQ5+HRsK18Z8r4lS5FHjHCSXPML8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mXEQlt+0OXue/bJ7vT/SIS9q9Dfpk3vOarHJ/Jp62vFHakvx
 	y8tOqHc3sLsfqIn+rRTAc5rnNVzrgWA9T/Kq2A6SMCjwwmnPZVyohYDwV90s9NinOq5klxgu0Xp
 	EbSJq9wRSo4DcpJF0bP/SoyoL9aDWeXKcMZsht458oWYbAFeg0Q4SzKk1n0/iHe8D3ln7tKXHcz
 	9+pDNUT9wF1rXU8WtJX1cs9Nud4bYSvffgg1GLl6a7
X-Gm-Gg: AfdE7clo5efG1WmdQzwda0btW82QW2M3JTpPGZ1EbPGiCdORIj9q/M/apd9WnSRh1Bz
 	1ooZRYPtMEcDMx5xhrYeelL7G80mtuwyYREfvickEmo0MvgbnNHL+lMDaEmkl3c6bBUlPeDk5td
 	djqyqApJjLdnVFq26nYbaMqNN2fKF5wyEhTyUewe+S6HbaRYalg52QI/ETnRmV2UZreuU=
X-Received: by 2002:a05:6402:430d:b0:698:3b7c:7e2c with SMTP id 4fb4d7f45d1cf-6989f38f47bmr824653a12.36.1782911302037;
         Wed, 01 Jul 2026 06:08:22 -0700 (PDT)
X-Received: by 2002:a05:6402:430d:b0:698:3b7c:7e2c with SMTP id
  4fb4d7f45d1cf-6989f38f47bmr824637a12.36.1782911301695; Wed, 01 Jul 2026
  06:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
  <akQIIav_zaK6RmIC@pedro-suse.lan> <akQO8JtTxmp89GS8@pedro-suse.lan>
  <akQekZUyoKadiGCH@pedro-suse.lan> <akUADHLWEetveHLp@casper.infradead.org> <akUKty7jsWJrdyho@pedro-suse>
In-Reply-To: <akUKty7jsWJrdyho@pedro-suse>
From: Gregg Leventhal <gleventhal@janestreet.com>
Date: Wed, 1 Jul 2026 09:07:44 -0400
X-Gm-Features: AVVi8CfbAVtUJ3lTyb378QyJPKoGbZ_N6e1vZmdlCalj-0NGI2vym8M_lSCjDHg
Message-ID: <CAFN_u7EE0ooQsH2JAnYn6EFrxnRToXAqvW_uUE0aqPDEPEmSAw@mail.gmail.com>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
  dirty page cache
To: Pedro Falcato <pfalcato@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 	Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>, 
 	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 	linux-kernel@vger.kernel.org, Eric Hagberg <ehagberg@janestreet.com>, 
 	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks all, it sounds like there is nothing for me to do quite yet, correct=
?
Also Zi Yan is correct, I meant order-0 folios.

Please let me know if there is anything I can do.
FWIW: The patch I suggested did seem to resolve the issue (based on my
testing) and did prevent my reproducer from reproducing (whereas it
repros ~instantly for me on a not patched kernel), but I (obviously)
defer to you all here.

Thanks!

On Wed, Jul 1, 2026 at 8:48=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wro=
te:
>
> On Wed, Jul 01, 2026 at 12:54:52PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 30, 2026 at 08:55:12PM +0100, Pedro Falcato wrote:
> > > @@ -2043,6 +2044,17 @@ static int collapse_file(struct mm_struct *mm,=
 unsigned long addr,
> > >      */
> > >     try_to_unmap_flush();
> > >
> > > +   /*
> > > +    * If collapse looks to be successful, flush any dirty pages
> > > +    * out the page cache. With the nr_thps incremented, there won't =
be
> > > +    * any new writers (nor new dirties).
> > > +    */
> > > +   if (result =3D=3D SCAN_SUCCEED && !is_shmem) {
> > > +           err =3D filemap_write_and_wait(mapping);
> > > +           if (err)
> > > +                   result =3D SCAN_WRITEBACK_FAIL;
> > > +   }
> >
> > Oh, the other thing is that this should be conditioned on
> > !mapping_large_folio_support().
>
> Thinking more about this, I don't think it works. On the file open side, =
we
> always truncate the full page cache, even if large folios are supported (=
due
> to possibly max folio < PMD_ORDER). So if we skip write-and-wait on such =
cases,
> it will be possible to fully reproduce this issue.
>
> --
> Pedro
