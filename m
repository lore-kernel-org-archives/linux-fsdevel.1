Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E183E717C
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177831; cv=pass; b=uRD4Nh/ItfVqrs4tEBWYhejSzt20+PfiWJi3OAsZLiine2nfNVgw7B7+LGXuH5GidLrhUCJSPcUeKHueT0eji1bHAnO6mmFS1TszSCrQcXuNWbW++mIoAMxF6ohydCdrBROTjA4ebMdizpcTTVrhi5m/hLF1nJ7HQpiJLDKH4nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177831; c=relaxed/simple;
	bh=4LZMVz8IVbVmU+1aXtGtaC8SGGzp6xAh935ELk3ODYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLGROwc/GyiIM/443P3VQ3xy+N7tvr1CZSsBLpXr8pthjGgOECmY+lD4d+WnME3AGhFZ9NJEYfMSwZ7D3MRUFeHZSW219xOB6VQsf2NFrsW9eoy5lGlMAxy+Rq8d3GM5DLy/k4zhw2FNN/Zdc91hcW9oUjFePWJEjXupvJOD3NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=exaVsC6Z; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="exaVsC6Z"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-517907feed0so9886261cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 04:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781177827; cv=none;
        d=google.com; s=arc-20240605;
        b=lnTZ8uDYr6n8L+0En2U+emRksHWDMM8uLbEhCTmGpgintvZIejLBaD/EA3zhqwJ8e8
         uqyUg1FwYlNL4udQYmhMvaKH0fhhLP8lksRlqYGV7CdJLbtOLN3FnS90w0C1L36JH8Iv
         pa9d8tRsCaSwAW2RGtHLCgW9dcoGvKjawfFxg1+c8uRk0+Ufs6DwGgv4xC+Osj8rVrEr
         P3j6MzsSibBjwJj2DoRUo3lUW59mM94oZlYofY83Y9/VmRdbDo0wbksQaebcKl/Q+vx6
         zpjS/XOIFxbb4pTfqnMYmEE5dKpR97iW3fy36pM5cd5lF6f2oHihm9SWdCr/32szq48K
         BTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Krbn+MYg+M809YBLBqA3HPhCu/oACb+iPAXWhxNcpGc=;
        fh=cbbJ+kpdDyio9S5mMEjeRtBN46a+GDwz+r+QjLdsN/w=;
        b=ayJvtrqrQqnLnfy8dYVXAHCwKVgLk+NesVFXQ2ix6WNoO6PKVgUEKTvy8PZPltFkOk
         LHpAzydP2O8O0UbmWHOsI7bLZ6jm8nUnf5AA67uroe1qEEDxV0pAN9J9D4SpssyHrMRp
         xzwJUsM4rr0QN8+SUAWOwx8j/FgOGKw70ORnSuJW0SRSO2dCys7fzxW471LG/RgYdG5H
         fXgHPBlDexLs83I8hdtbqMBRAY0JxWuf5WPd6IJRotFO9WwhZsejKlyR2/HLPztXrEjX
         3Q4Ud6AvNEbzdH+qF02tWKbAFIM/ikCGrjhyCOkTQ27OVhIHQRuaTv1soGKTJESe7VkB
         PqGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781177827; x=1781782627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Krbn+MYg+M809YBLBqA3HPhCu/oACb+iPAXWhxNcpGc=;
        b=exaVsC6ZwrG2Tl79VZOH8SrQO6mYjkuc26oaQ+MkkvfDmSNSFbwriltGyEsM10pOUr
         x2pvKVMLuFxeFBmLOiqGb1Bf+uAtGn9+k5MX1BHYTDF3xofNMK9ivvjj4DQ8UW52UKcJ
         rcpkmoJvnIotPmd0Mm+7Z9FDah4Ta0g2EHJ5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177827; x=1781782627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Krbn+MYg+M809YBLBqA3HPhCu/oACb+iPAXWhxNcpGc=;
        b=nd+y+5MTckVkdivXbmGPY6g+8DYU0BERPdNdbUsa0H9KI7HNVmN6MdW9ezdN2DB+d9
         mGldCsNKwqHZLFMfAkrDy9MHUFIkMzxWY6UBjdUWlGsQzfiv/ZD9o89fpq5Rmkf3kq6k
         5ZBkxC4SgehyKzHkTFM/z78wrg9khDeKlUgfZkZ74cufxneV6ur63VOoixJLYKHktWUf
         q1aLvtSi7ucqrGH3UpaOe2x4JOjaotY1X400tKG25HKirv2jlrBSTL4gR+fUbhxyQIm8
         vNtER862zExLzpTlm5wwo2eRSqoq3SwiqFJqPKvHuaXc+TCVNZlONT7M7WfbFxMx9yPP
         tHRw==
X-Forwarded-Encrypted: i=1; AFNElJ8K9wOF+5K9Ye2+5OBUd2M5tHVzyvEOLHCQ8XL8V2tkUppGFbx4ckP5FycIkVsf8VLyrvBvtieF0nfgjSpe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64G6y1EhoiMH5ml06xykpyn+4u3t4vFAipqgUBRaRwi2VFLjg
	iDM0pNuSUZBBW/ozFuMtDQUdtwcg5KxGhESAgviUFgxltTZWPqINolecxKmDiXxqnjK1LPH9f2m
	Dsz3Dal10UId+B/FBysZGLjI6ThXBSjzpQbINSSpyqA==
X-Gm-Gg: Acq92OESB5g5paardUb8YrYtHQanmJMVY1JH/iqLw3IKJa6KKDgVD2Xa9hZ2KHJE9i8
	9ug0TR2zjIrsUGrn/cAMK4WzXf1Wbxst3rvqZKRF3KAdp2jPv52HoCKVbYXbi0TX9wOn68dL3hB
	Mg8+ZF3ImxWyNSleGL0kdPo6JPmXqH8qN+e9YC645sX0qrRRpkaT4C68l89T+5EF4x/f4y+hgOx
	ejQ4/rmwXRtKFKqmWKM/wDFvc/2J+x8NL98t11pZPTd8oV2pb2Itzzouuj6Crv5Oy55sYqsA6c5
	s1ew/Anor8Rrn9HoSOB5/u7aaAWVsbXb+Gh+r//wLHeniOqIg5bKD+m5yi/RNw==
X-Received: by 2002:a05:622a:2c3:b0:50e:600a:638c with SMTP id
 d75a77b69052e-517ef5e438bmr24070671cf.17.1781177827196; Thu, 11 Jun 2026
 04:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me> <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me> <aeFuarTL7xBbut0F@casper.infradead.org>
 <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com> <9fe5ff50-4c1c-49ee-a8c2-4cacc3c6781d@fmap.me>
In-Reply-To: <9fe5ff50-4c1c-49ee-a8c2-4cacc3c6781d@fmap.me>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 13:36:56 +0200
X-Gm-Features: AVVi8CeK6Z2zBhavJJXwn1vbtJS7ePzzglnt_f4GGpdHii0ALfHsK0WKEmVT6b0
Message-ID: <CAJfpegum=LJTCGqMUfLHehQE19kgdZbE2eXS_002fdpX_sd6jw@mail.gmail.com>
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
To: Nikolay Amiantov <ab@fmap.me>
Cc: Matthew Wilcox <willy@infradead.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	fuse-devel@lists.linux.dev, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 18:49, Nikolay Amiantov <ab@fmap.me> wrote:
>
> Kindly bringing this discussion up.
>
> On 4/17/26 20:48, Miklos Szeredi wrote:
> > Should that code check for a truncated page and retry?
>
> If I understand you correctly, this can be accomplished with a new page
> flag because there's no other way to find out the truncation happened;
> would you say this is the right way forward?
>
> Sadly I didn't have time to try and make a PoC fix yet, but I want to
> try tackle it this weekend; meanwhile, any guidance is appreciated!

Sorry, this got lost in the noise.

I was thinking of something like the below for fixing the invalidation
race (untested, whitespace damaged):

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..c9ab0eb35afb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2856,6 +2856,14 @@ ssize_t filemap_read(struct kiocb *iocb, struct
iov_iter *iter,

                        copied = copy_folio_to_iter(folio, offset, bytes, iter);

+                       /*
+                        * Has the folio been truncated?  In that case we could
+                        * have been copying stale info (including zeroes after
+                        * EOF) for a distributed fs.
+                        */
+                       if (folio->mapping != mapping)
+                               break;
+
                        already_read += copied;
                        iocb->ki_pos += copied;
                        last_pos = iocb->ki_pos;

Thanks,
Miklos
