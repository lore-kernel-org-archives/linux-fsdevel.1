Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F325315D58
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787504243; cv=none; b=PxBRsj88PYu+XmxcpevC+K1/frxPc3MRRUxVihycMGIgTj6zVkaGP5hKdbdrdAUuPBDDBxJ3Ppik4IQ3xQtRaQoISRgKtUf9S+51GoIWmni1Tsxj6Q/9exX/IVO5AcH/boeK2kiWze5JehkRRmlmy7ZXiwxh/Vuv36EvhPR2sbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787504243; c=relaxed/simple;
	bh=FifPijUxYmOn0khIUeWNQnDh6M3c7SYp2DOwVf6Fxy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOq4xU7vh4rkyJV2r3ELxYjStzbIwcupWG+lxgKTtmlKSJ/2vVlMGdGBIUeimbjaIg20FCHJb+ulOWIg5T3BxAn76ny7ZOnUWjZ+o+SCaOuoK118ASky+IdmxFijfRZofRy5oB5vZOLAOLELNLZAejtcHFi8S3wBO+KyPRUif40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cA9cfIUT; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cA9cfIUT"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92edb12cdf2so173313485a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787504241; x=1788109041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=syT7GQtDMHPLcTTAdV7OL+T3aNWROaJmphq5EZ8nhH0=;
        b=cA9cfIUTpxGrYFtPA13FvIn6W61JHx7mZ018cw5Q2kDv7mDQZyB3ALNaoHWv4H17C7
         lKQEyxsDQuqR0Ap/X7HxniLHaRpT3HsxkdZBF0iJWaejf+/R/ORb88CcyxV7uyq6cAvb
         As0wrN7FkdWOTEitujrB8go3e/VC+lpoOJG9qLlCDXkCGzTwEZRgD9NFE0BaweQijY7w
         R0JlcIzXaQ3iK2M0ZpG2A/sN/dLX9gqJsbE2dzLasNgCmRLd9blSedtSi5QLqFQHT1EV
         fkDN5CAwNpFAMg5xBIGp75GpcpgLhIPknx87KXKClBVzZM7R2AtJ/NbrJgchuLn5Hoaj
         eqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787504241; x=1788109041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=syT7GQtDMHPLcTTAdV7OL+T3aNWROaJmphq5EZ8nhH0=;
        b=BEfE/mCir3DBbwrruhWJ1MPUEGvCKNoSvOm3jEo9CcKJpe7TMTbi/mGXx8U1efDrQR
         xQIPBXa/Lt8613JGfTFdy9817viN+EmnJ9A7dRINxNNs40cVSoWWYCIIVRCZ8RfxG27X
         Alii17Z/hrbVTJdkwDZYdzQPsl2y3pdZGX3fGpSuZcX42OR6kfXnHriWGazSeS1QEefd
         j4RyJRbF0omL1PFaqleLS82NMckoG4rCS9v/q3zE2lGQAjBFt/pm5Ulgws3HzT4EQwR3
         YI6BKNwAjWQNVnQH/yEcWyg4ylUQXO5C/cnI0QMnwB+JCaJafkexE526LyBTdFCcGxF3
         /4CA==
X-Forwarded-Encrypted: i=1; AHgh+Rqiwn0OUeULTaKoEICNLJUOQ+J6RIH4z/PT81D5fmPNSY48TvqYZSoTzLX4snTwwMFT7xqgrL4TpE0ZPXbU@vger.kernel.org
X-Gm-Message-State: AFuF++lbqxkoqPwUJ8VOfBZGOXpGTtWQ2FRXpaRwrmnDUOltuFh00Ekp
	ZholVFA2T4ahG74a0oNLZroRYYmBs/gbUdNLUjdkqsAilHMs9LRShCI2jo4oE3Y+26w=
X-Gm-Gg: AR+sD12C4rVD5voWSmqHE7wYjmrrQWXFQJ1aVl3HUF0p9XaX8FGrtyqr1B30pvcoNvi
	6Y3N6sCZMT7nTNjwaanAjSiQpsdlW4NYYSFwRTwCAP29xaInHJiVl9xoycB2NDKc4mkuJx/xAZc
	uRaoyBrnhWdi5JN9mr7ttEkSDdilQ4pIIuL6ZLJLetnjrj3bhBZuyqOBRYzsERAfXg+YzZSVGsA
	FqKSYlIV+iopaG3cYsIiL3lRqrt5q3g7bdTxda8vuK9RI2JbiLqu9r6pu5ibHkEwOvQpgRxA95a
	INQG4ntdXk+b8DZw65VKzewaBDKHddRY/TEpcJhsV/Wc5H+4d8KAYs4R6A7xYQ8LE0Dh+ZSHdek
	Dlq8fJ5Khc7yZHYi9pv7SRpBbXj/kWb0DCcDzO4Qk+wO8RBh+u19uWJ01k+2G4DJBqXgWQEv63E
	uNSCQ8/VAgudiixxY9Ca0ZnGcTI/3T+QQXsTLCP5yzZYe9OMsNcxlckXFsbarRNKj6EWFO0gjE8
	YrSPgN9oksHzfOMtFalgEESDEu7JTNJFZxnQtfMJMxS
X-Received: by 2002:a05:620a:4142:b0:932:dbf6:6f9 with SMTP id af79cd13be357-9373942e4f9mr1755655485a.9.1787504241119;
        Sun, 23 Aug 2026 09:57:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749ea4cb8sm328642485a.41.2026.08.23.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:57:20 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:57:17 -0400
From: Gregory Price <gourry@gourry.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Jake Edge <jake@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <iweiny@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Haren Myneni <haren@linux.ibm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Gabriel Whigham <gabewhigham@gmail.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, "venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Subject: Re: [PATCH v13 10/12] famfs: Add runtime operation-permission (opts)
 framework
Message-ID: <aoslrrY7CrpmUc3E@gourry-fedora-PF4VCD3F>
References: <0100019fed5850ec-2bdfb17a-3086-44ea-8fdd-777d3ce12a33-000000@email.amazonses.com>
 <20260810202539.96378-1-john@jagalactic.com>
 <0100019fed5a5210-a09f1bdb-c705-44fc-8108-a7e7995a7af0-000000@email.amazonses.com>
 <20260822000728.GB6047@frogsfrogsfrogs>
 <aokdSo9li0RtEt35@gourry-fedora-PF4VCD3F>
 <20260822174029.GC6110@frogsfrogsfrogs>
 <aosejKmNJxCIpQho@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aosejKmNJxCIpQho@gourry-fedora-PF4VCD3F>

On Sun, Aug 23, 2026 at 12:43:14PM -0400, Gregory Price wrote:
> On Sat, Aug 22, 2026 at 10:40:29AM -0700, Darrick J. Wong wrote:
> > 
> > A bigger question I just thought of is sharing cxlmem between files (aka
> > reflink).  Is that allowed?  I could see a theoretical usecase for
> > programs A and B wanting to share some cxlmem for communication or
> > heartbeats whilst having their own /a and /b files for their private
> > memory.  Probably you'd just create a /common file to do that and not
> > map the same cxlmem page into /a and /b, right?
> > 
> 
> Anyway, there's "allowed" and "useful".  You could technically do it
> (maybe not with FAMFS' current guard rails) - but it would be useless
> unless Process A and Process B were in the same coherence domain.
> 

One point of clarification - useless for both processes to write to the
same file concurrently, hence the need for a producer-consumer design as
John suggests.  And even then the software needs to handle coherence
and cacheline write ordering (which is also not guaranteed across
coherence domains by any current specification I know of).

~Gregory
