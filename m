Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2B3859D2
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578979; cv=pass; b=TLYkbINz/CbMdxzTmK0enYl91AmxADjGDEygwa2iOqy/FuF551L6TTnjeGCzfByGzQVwE+rBS+/zTMfxdk+iONTy2aa3JZPyQk05kroqhl9AzOdcHvQ+z/Tfntk16zY7+gn6a64fmPuKLewcvs/aX9ADr4utmufLx4iHI+MT2Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578979; c=relaxed/simple;
	bh=s1OOCWLODmyroeZNuSEN4pTGxnWil2MCytCdzrB/lk0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=V0njw0CKQ7iBBSvq9JfTZ7R9Px2HT/dEaut1F28lg24eQfvoSvJ59YzP5BEPmv2433PayjA4VhmIO8IVot8Q1fJ5uvjhgIM/bnqZmr9v9hpvABKq69nEYlIfDMaztovEvKxH/VNjrX9yI4D57/kkshV8Q3h6g/pM+XONrXLbQkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxBGjx8e; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxBGjx8e"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36643b96b99so3357698a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 02:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778578976; cv=none;
        d=google.com; s=arc-20240605;
        b=ChtL1Ah9OufK/KBMsBl5HC3Wa2gke+l9vma0uDWTnNDKgfNa69tvWgexXddwx97UAc
         S8p0+KSu7rPtV+ZGY4IvkbEgy4r49xhDs7xvLjDIbB4hxGGlKQ1CNtsEp68rDuMvcY/A
         WQ3gObK3uhFZIw4YhGPItYz9K1tulq194bjLtUR5p4CobsfzvPjXUi3XY7LvyIpR/LcW
         03DdtBaB583JRqAtqhQJcRrh4d9qQEdgnLzhCcGHg1ztLSonfGy90Tf6sRscyMqcRysT
         oXdxJPxec3cJ4Zom4yAYwILda2LCjHmw4yeBfLaTPBq1+SUXifPI25s1GgFojeC0AfaG
         4WLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=s1OOCWLODmyroeZNuSEN4pTGxnWil2MCytCdzrB/lk0=;
        fh=xvkMiIXwW5U3t8BXxFaLVv0bRd/BV/cFP3+89Vx0mBA=;
        b=FoJMMUkmPOeKfFwnqhByBtpIUqV3Hb22m6zpDhaxEJ4DrhZTIZ8sZ1ahhK0E6wk9xg
         WlbUT1V86jNQUE2k7pKN6WlykgCujL7GoNkLHNe62ozKvAg4ZigAq4XDvglQtx6K9JUm
         cMCY6N6kMry9vEXiahWY4noeZVzlppxKfrtNs934TZ8tELPxXm9edQD+jGf8Ka3uMDJA
         39tOY62yFUWtHKizh+swuFgtkzaHdE8fjmyvDzvIWiTpnlASsDFYReFyIKOSrLBgqB0x
         dELscpg9/r/uZC/HC/AXl6uow16lxBcHF/x0YvnfdxAbV/WnLC3jdZPEY/0aZ6CHMTqV
         iOtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578976; x=1779183776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s1OOCWLODmyroeZNuSEN4pTGxnWil2MCytCdzrB/lk0=;
        b=hxBGjx8eXH/xlesgd90tbK/0Gj5JP/tdt1niCksHtO4MCyAip9n+oxtRVf/F1v/v0J
         R+lUVe6dQokEqeGi14ifZKWYPTGPHik9Yn+1cA6PSOEGjbJ6JzNek3fKquHRN1j7YqIP
         VpGaEAe8y9CTc0I4U11PIdRwB8Fyv+d7N9h5UL/x0jVEDyKO9uHqORgCTgQmpr6t/BfU
         sypaa1XzQYFY1SNO1rwzuqTN1Ebl5RM9jYpRWFt1M13uXG0xNCDPEg7rZaMyfglMpfhD
         Z3elsbyMdGUeE1kD7D9MOJcrLkND2nxXkGMR2XsaTlQUwlBtfvObxMbKdbjGSi4wD8XM
         0thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578976; x=1779183776;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1OOCWLODmyroeZNuSEN4pTGxnWil2MCytCdzrB/lk0=;
        b=fXEIkYOjR+JMDprgAfJ6X5VpHaZ7r14DQ+DcE3yTVfWJKSXs3RrFf5uHnwa/3tUyJW
         O/QlfkovmlCO5muQ/nLaB6DFCPlj97qSPlWRP7nGuufWUkOXcp4KtJxH3jomvHXfMHVB
         L5yxqie2kQEj/5yQ7baW5kbzJkSWsZM2NQ4kV+JNaQ81ZciMyTL50wwIpWRcAkk24m8I
         JJx2vT8RSSj8c3XLtzICSxs/Hd6u/4asHDiqoFKUGS4EzFCJm2/vS71EplXsHt4eNAxN
         0j3nr6popVcK91yDAfEElRgxX5psNP77KpMYGzCWwmWnEfXkF+QU8F2clYcF2uE2bdW9
         F4lg==
X-Forwarded-Encrypted: i=1; AFNElJ+7a5ppF821rn+8F+DKfnjfYqqJchgAnMdYaSkfIvBplxwjTY4dZRXr06RhRSvdVxWEjgZ+l8+mmuA0wcLG@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5Nfq7b53gLwibZ55+linddPmzRzEby6h6wgnz/WLIeVMpWoT
	60JJOgLh/T54JSasV3/oagTXbopqSC8XFF52P8AR27vFlDCpZfzXQ1/NQIcVv4AFB1SFFuM5ClQ
	FkvQ2/7941VX+1D+j0qOuZfEt8qdkPFA=
X-Gm-Gg: Acq92OEApBDhbfOZGGltJlH9kxfczNX5h+8CkTXpSozzkFDl+OqESRjy6KSJ4NC1CvZ
	Mleg4YNtZuaYEqSToXL4AElRGRLXyzAiiF2bLLMZYqyGrDugolEr5nvSFW/cThxJJQdVYYug2Ot
	889Qw3hepIx/mmTAxhdXmgKr3p0GAaODYhcX2CAGQJ+4xvnZzTsOi48PGePPMM9YAmjNejAjuV+
	JcDGQyuG0ktEEQHs4z3aW7fZexHA5EVeR2i9abtwJH1GVFAjFtjjaFGULin8lOhdUGzN3sXBATJ
	Hg9ZQv/xWv8EmrC71Ok+4FCo3kf/JVyXS7MyP1tU
X-Received: by 2002:a17:90b:2f4e:b0:359:1130:1047 with SMTP id
 98e67ed59e1d1-365abe8c511mr28287381a91.17.1778578975903; Tue, 12 May 2026
 02:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arun Rao <arun.rao.bl@gmail.com>
Date: Tue, 12 May 2026 15:12:44 +0530
X-Gm-Features: AVHnY4LClgZTeSogklM5klzYgIGBPPxQMCEVETX2llXKICl6FhLrQ79-z4quLNo
Message-ID: <CA+2hknjQ1wLjXdhZWezW=9BwcUhoXhXR1Yi=N8bhce-Qe7+RFw@mail.gmail.com>
Subject: Re: [PATCH] docs/power: note Btrfs limitation with FIBMAP for swap
 file offset
To: hch@infradead.org
Cc: Arun <arunraobalappa@gmail.com>, lenb@kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, pavel@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

Understood. My intent was mainly to document the current behaviour
observed by users on Btrfs systems where filefrag/FIBMAP-based
guidance fails, and to point users toward the existing btrfs-progs
tooling.

That said, I understand the concern about encouraging users to rely on
resume_offset-based workflows in general given the underlying
fragility of file block mappings on moving or CoW filesystems.
