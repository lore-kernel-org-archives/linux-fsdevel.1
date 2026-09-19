Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3937F31C
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789840981; cv=pass; b=YmSaBJAUb/u1U8y0DnyXZtgbczTpMV97rCUBjLYRdtu7OYFIncOqvLGGbt+SUEEJM+iVZU1IoZKez1w5Bjvcb96rt4JJpKfYEJAz8j+cs3m5Va2WyuQ5Y1Q3bgrnExrkW5xDBbbjUseiz9UXaFlL7BgLqi8xJDYqcUUHTQD/dp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789840981; c=relaxed/simple;
	bh=ZnIxT/qMr1gdbVRylwtNaFD3JyKemoHZb1UvE3gbJzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lV3ALhcRmoTU/tlcH7yMNdpNQM/M9Q/0AMKy8CAa06ttpM0xT1yPllzE/Dzde8ooaB1sepEJbdJQqgX8bf2Qc19VHHEoe93/Pe9dvwndC3YtLP8l+ej3s7IgKEETwEwzL5BHGBl2wtXXdG9nzmbUizhMsFzSMeegxpVmFG/VHwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqCIAJli; arc=pass smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqCIAJli"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6bcc0c495efso981321eaf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 11:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789840977; cv=none;
        d=google.com; s=arc-20260327;
        b=d1UxJgtnHQA7F8v0nmInDQISj26wzWm8yeseK0vOPCPI1BrHVt29MimWVzLFJ96Gjv
         w1yy5Qwp5vYhvvxpxSUuWwcvr4nM0pPUFFGGZ1v4XNLm3CZwmLgrT6MlT9hthbAExmjx
         ibfvz2UpyWNffDXeSg7XVrWFaPP9Yj9GBlL4UBgnCEv3cYohucSaSXKoJxjTL7JuuLAM
         VxyheQ+vuDDjx36yDQqjWH00JL5f2xxhFOU8qtnGkADU8vwXVhPNxc5VDYZK9D9HKWnD
         iZVioyqYCW0bgN2fxeyUCeGa+TS64y/Ot51squrN0Qe+WNL+9i6Ka94YqPNLQp8Eu8IG
         /LoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDKPZzjFZ5Bv8sDLp41bGNciktq2X5zHxI+b3pe3hs4=;
        fh=yOiudSuk+B/rR47n2F7nA/XPr/J7mTeztq57UTMxu4Y=;
        b=PeET+OLeYmHAipGW8gDG0TaRSoUI7qhlJTAYM77fVd8OPOzFLI22IHkqHZ9MHd4mQB
         XEQ9o74R6auA6R+3V5QvGX52mw9Nc57E6NnZ0R4PU7PnyoTF79mhWWS+1qZMLpNhYQw2
         TJsyhS8FIo3naSwUQFbUSex5FjmvMBfh4UoS1lA24TxfUgG19wcjB3qILUb+eBE64WUE
         y2mTJ5KA8XoR0wAoxHeKoRbJnci9kv4y77XwApb50cf9uyuDrb40QgrJCJFfjP/gitq2
         99//Vyijo3et9EggzCZ2ZLJKVDPycuYFpMruwXU2R6HzbFkWXYHlyvb3spyxTXzQ3+La
         bLlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789840977; x=1790445777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NDKPZzjFZ5Bv8sDLp41bGNciktq2X5zHxI+b3pe3hs4=;
        b=RqCIAJliHegb50OkBHm0bSinDzC6IXdxVS4KfIA6aSfD6TZCJA51CAIgaZwK+AIF/6
         bdnUuTDIKUgPR2yFwkOgPzRSwyhwJUKcPhoW/wqVTPLsAkpoYB+b5n8IR3VzHB8yDOtq
         JcV/as89DaXawq3qmTrPbiSdnlJtqkB2EX+ku2m7SjRQfkFToXjqrHyvp8Gw6p+7GTWb
         /Ea7DU/Q5A1yh+Q3SEC06587ZbdC69JBDejvDjem5MkCT7UhrNJL7YoX2guVuv7qC6XM
         JcT6WH5Ymjh1IblmpJr3twcyVPaMBk6vmLKvbFRRCUDRmqGFchEzDM9JCUIUn1/PjRFv
         NaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789840977; x=1790445777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDKPZzjFZ5Bv8sDLp41bGNciktq2X5zHxI+b3pe3hs4=;
        b=laK13R6kiuao6owRS/qNNZQvhWAejQZyg/RSdbyyjh7Aa6sdB406UxdjWL+a/FSCmh
         PhkwM3ZkgYbh4GG8u6K8nyqUelS58QlW5Q6GIx8eLP52er0BYbnobxfWa+bzHDZX8l/G
         4+hXD5fm2Oby9GT9cQpC8SU8EWbD6BBv0fCnz7ssAaD5HPGsDnuIkUlvL74MxjQrsYbQ
         jPKnr7bimgzH9YuJz8N0wk1dpaU/z03dM26ynUWN6A5eQon4OKtvzY+7BSghz7Tf29TE
         +kWM78I8/ZLtKfeOy73j9IUsYF5mS9XvB8gWtKcK5ybGkfh+wdeaVm8fPk6WZljMBhTF
         KxPw==
X-Gm-Message-State: AFuF++nuXKvHjoHyHZVX5cvZCV+5oh0oL9MHrjEfzGdqPX/S6wmOAIFx
	M00ZQX2x4xuzr68qCCEdBNBSmJMnVLjiBfjWwS/h0Z67DohBE1UBoTzSBU3Hcbfv0jenypfZn0f
	smwoEe51WH2/y3x5N5wUwkIDHO2PLjrs=
X-Gm-Gg: AYBFou2+r/AAx9mE8bqSf1ygyZ/hU1KGQo/XvTYuOdzwTmW9xbhDZO2AnlyQYrWbwYo
	WtDlF8+HVZLPg/ZTLkoRSPUJbKA4c119vOLTQCniUVJSh3VbxbmjsACIEGq2XGaXIAwAmxgwkVd
	r7mbinbqPLoWxKqhveQ7sU+GKlt6QbLv57EVpG4RRstaN9XW/8gtyFnU0MGNfFkZp47sAWKcNLQ
	15lzrdZAYYEY2aqPOrSgXmdbOB7V3PTYii//4nu9fU5G5ro7qn2Ane2Z8c6PXcNDqcHxgqrGV9f
	zVk2jqvJcg/SAgznCmr8Fz5uZ6lVs5puv/evxJhb+5H+o7EnDfSps1Z/16jcRu1jqVYzAMn+VQ8
	wcIaQp9VYTP6Jpsdqr2XaA4wPVnnbvSgBLtITJ2B7
X-Received: by 2002:a05:6820:222a:b0:6b4:117e:543 with SMTP id
 006d021491bc7-6ca9aa41fd6mr5401676eaf.21.1789840976828; Sat, 19 Sep 2026
 11:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787770110.git.jbingham@gmail.com> <668bd5f317e3bf8eaee0254ca79e595395b6e332.1787770110.git.jbingham@gmail.com>
 <aq1UW699LW2pxvHU@infradead.org>
In-Reply-To: <aq1UW699LW2pxvHU@infradead.org>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Sat, 19 Sep 2026 11:02:46 -0700
X-Gm-Features: AcwNN1WZl_zWUcTPKwWMEvYAQm5b_50lhzbDf2T03tQlLz_DhKb6TapJfNS5Vdo
Message-ID: <CAMyBmMCJC6F=y5_3sbC+2t+6NZVkD2ve2xOhxLDeLPfe7YBJUQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] minix: finish wiring in iomap functions
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, djwong@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've seen all the comments on formatting and will be fixing them, but
I'll just note that once and not keep repeating myself.

On Fri, Sep 18, 2026 at 8:10=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Aug 26, 2026 at 02:41:57PM -0700, Jeremy Bingham wrote:
> > Wire in the new iomap functionality in one pass. Per Christoph Hellwig'=
s
> > feedback, there are no longer direct I/O operations. Without that, only
> > write_iter in minix_file_operations needs a custom function. That and
> > exporting minix_setattr for minix_symlink_inode_operations are the only
> > changes in file.c.
>
> Commit history just goes into the cover letter.  In genral you don't
> need to enumerate all low-level changes either.  Explain the high-level
> change, what motivated it, and anything that looks a bit unusual and
> unexpected for that high-level change.
>
> Note that you probably want to merge this into the previous patch
> adding the actual iomap ops instead of leaving them dangling between
> thet two patches.

Indeed, and thank you for letting me know that this ought to be merged
into the previous patch. I didn't want to run afoul of making the
patch too big.

> > +
> > +     if (ret > 0)
> > +             ret =3D generic_write_sync(iocb, ret);
> > +
> > +unlock:
> > +     inode_unlock(inode);
>
> For most file systems we try to have the generic_write_sync outside
> the inode lock to not do the expensive sync with the inode locked.
> generic_file_write_iter also doesn't have the inode locked, so you
> should probably sync after dropping the lock here as swell.

That makes sense. I'll rearrange that.

> If you're looking for another project, we could probably also have
> a iomap version of the directories in pagecache used by minix, ext2
> and co eventually.

That does sound worth working on. I don't love having the directory
operations using a completely different framework than everything
else, but since minix was not the only filesystem afffected by that I
left it be.

Thanks again, and I'll start getting this turned around post-haste.

-j
