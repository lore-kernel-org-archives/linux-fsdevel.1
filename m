Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFD40097E
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438805; cv=pass; b=J2wX9ukm2O6csFm0139HLf1w9/SZDs2wc6CErn1OZZG74cx6cLGs+5mfoeZvtu42lOyHZyf9otJmCDlMk4gaBHT37mt/J7q9xU4ypDtZRApvmpKwQToLSPJb6i4MQsqLbuYRUcXdpEvlgbSzKjHHYuI8ECZZ2Mr4u9q9SIxoVUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438805; c=relaxed/simple;
	bh=QAVJs6W1FBqjbAOF/0emhNqG9jbCkXvsyG1EUwOkxnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaB5+zbyqsklKGnj5ksl67Xx3pE2kHPzB7wiQ6mOAQdT86NsQifzJUhRRDmFiveZqPtRRWYRpw9UEoYeOCwx3ttFVmPGIuuLHazBlqsydrVEADFtGUSlExp87UfCtkAp2cVa4noEbBm+FQBr4UrElnsRhBWhI0vrPP38sEhXS0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nVGqfVwW; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nVGqfVwW"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-930f72317a6so22016685a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 02:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786438802; cv=none;
        d=google.com; s=arc-20260327;
        b=FxFCHgr1jKQvFDjx78R3X8+uLMk9lZQUDknJ7uAlH7XvA8hZJUkBkRmCfFpIv3NTeJ
         KFwaLJdgoaB8OoFuhz7/rkz4Nwb0PcdJ74h5QinXCF34gFSNtqTRX3F84GbcNetkVovd
         jkqgh2c3q1rdUrCd8I4BmDYwOAX2SfcvJgVkrLsKSW4SyBcl1w0jeJvBXpMTw50v93P3
         Y5VQBMBz8Vj0T5WBjrNjpYGfT9VUo1SDVPo68cMsaBiWuiGEKYmsNda0tJrAu7byuBQd
         qafz55D8iOard+e3Z4hEtisf9AynFyXPiossb8VJawTJ5Msq7BDNfgYY7miGLkZHCGX3
         teIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=03hUfqpAtMk8895qbCCQElojWBhsj8Ov0HHep5mUb5Q=;
        fh=woZN1bAKPpCT0yvc1Zwj9jEjWuPFx7oueDEBITVjLaA=;
        b=a2518Z6DyQLwhacJFlqgmNUidHbAAN39Ue1A3/JUuAK2W/ZeH3b5vFtTp1ui5SIYjt
         uJo31JxjonXk6k/Xy0lCfjKCPhKo5W4BosOYGp2VMnCMKYrKeyKgVbIuxJ8xRpbp3gy6
         F4nY718WUvqsPTiU5ysqCB2ndMxWJtEsEIJwPtcOuKfUrqzexToTpOwmQt0nm3iRNSbr
         coZuh4KUKO+QDetWb3j/ccUklFp+oOESZsNtwv0+Fvg9yRpkFSWGex7cnuBWlJqllVVE
         YQ7r05cePhsMiUeVxFcO32/ACnxD7P3eeyq5v5cfkQETjTPOAUzjroXXYkB5B8x0D4RF
         dUxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786438802; x=1787043602; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03hUfqpAtMk8895qbCCQElojWBhsj8Ov0HHep5mUb5Q=;
        b=nVGqfVwWjlKnDAMJZhh695o7awjKGLhip0xvSsLu4dXRYuA/MyfJugV5EIgcKGVMek
         eViV3wgYs6WFhvQoXQjmOEGfuzMB8q69VBLz1GmMjUqkH6R3kn5QKpZUsFR3zbQIzp/Y
         aCNfEHr2HvjU3d8lq3tRlSU1rp9TZCMV6DJN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438802; x=1787043602;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=03hUfqpAtMk8895qbCCQElojWBhsj8Ov0HHep5mUb5Q=;
        b=S3UgC8x1Fj8jvlvUmuicKR6E5wML7BPRnVZDt7c9wt6l4Ebjuc/WG3mLKcnT8Ad1br
         c0aRaSoQrFobhhNF5zhNlvFOO0wzkIMLY7EQKt1e7uC35ZV/XGjgNc3QX6EoeB/DdGom
         4fIUB3bTvpNGXJdtH1YLnw0MbloR+acllfF96V1nHGu42EIQKlNwbFwgIvBKQQ1Y25Mr
         gBlLgtt3jNK1+3zfakSEa2NggL6CQdp+4bebDCLoZLkEPsP/uA0pCeBVhBY8sFz7PWgN
         aA7jGlPoj2OPfBzljqIi0l0q7ZGNt9KpwE8YZGponjgZou8pwWrnXQhAhoyGnjx5uZxG
         pGnA==
X-Forwarded-Encrypted: i=1; AHgh+RpNWR1+eCma3iSU4zyA+skK8KSYnPZVc6Uj5RLqX3NHNp2Op2QXdxAb81OLuHZLawLz5rizMQN5FH4GMeEn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vzB1Nip1ptQ4X5GEdaLq5zp28uUscJAalGrNboUDTv8BdL4L
	BuXUbjz8aA17Wa0/ADQ1eEI8sYrCNjwCCK7NJypP7FdEEcbkHzRdOoOxA4+D+bxfXoftlgjKQbU
	GKpcebiva+FXY5HpzHYQnsNlT/G0QCilY1hIJ7WQsmw==
X-Gm-Gg: AR+sD11jzeJ41C9vynylu2dybm8D/l3Z3f46nDpla/8YNeDsI4BebRRFF+kmtS4FE5F
	7trUch1klfr/TgZz/AuC4LD3rKoz2fa+py8DN/mVX6zbxWYFsJiShuppWWz9xMXco4vDjEVnN41
	1oKVfD61SkmiSpjNwNANE6sjWtMbS1N4l9lVWUcjo5tI6I4+0vf7CRk1v5YeFZ3A8mI4GVrSNer
	gwZ17xPicZo40G0FAniFXTsHaRexLbrJRGS6ar10TfoRc6kUiWMQZ4Erx0JO812uLynJ/flCXfX
	i+M4hBF4tB9pZ/woTS7b5TXI7DE8mu1ZqEvDbuuPnqJ8Ias2n1xas0YFKwxqfEEMlb6RDEh/2EI
	tFcLs28xBBw==
X-Received: by 2002:a05:620a:26a9:b0:930:9774:868e with SMTP id
 af79cd13be357-936a8e70eb3mr130606285a.7.1786438801859; Tue, 11 Aug 2026
 02:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0100019fc572ca94-ec363dd7-3a77-484b-b4b7-f2503a0931a6-000000@email.amazonses.com>
 <20260803022828.75776-1-john@jagalactic.com> <0100019fc5739e5d-bc002300-eede-4c40-9ca8-a277b754496e-000000@email.amazonses.com>
 <20260806043712.GB3560084@frogsfrogsfrogs>
In-Reply-To: <20260806043712.GB3560084@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Aug 2026 10:59:50 +0200
X-Gm-Features: AUfX_mzPBN-WtEK90PQcEbgkE1jczoRAdcaPSoPUxrlnLvA164kB5DWNAs636Zo
Message-ID: <CAJfpegtW4bFn=oNfTipCxhiExaqSXnhXeBd6Uq15FpepqCJaPQ@mail.gmail.com>
Subject: Re: [PATCH V12 02/12] famfs: Module operations, fs_context, and mount
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, 
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
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ira Weiny <iweiny@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Haren Myneni <haren@linux.ibm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Gabriel Whigham <gabewhigham@gmail.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Aug 2026 at 06:37, Darrick J. Wong <djwong@kernel.org> wrote:

> IOWs, let's fix the remaining wobbles (if any) and just merge this
> already.  No more side quests through gigantic refactorings of fusex,
> that's too much to ask after you already redesigned and reimplemented
> the whole thing already.

Without any intention to change the direction, let me just state some facts:

 - it was never suggested that famfs depend on the fusex work in any way

 - the plan to add famfs mappings to fuse was laid out two and a half
years ago in reply to the very first rfc posting and has basically
remained unchanged since then:

https://lore.kernel.org/all/CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com/

I understand how that seemingly simple API addition was overwhelming
for John, and I should have been more proactive in helping with the
implementation.  That's entirely my fault.

On the other hand John could have been more trusting that the plan will work.

But that's behind us now, let's move on...

Thanks,
Miklos
