Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFF4CDDC7
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770297; cv=none; b=ZnvTnzmecUWWc8fLYH+mUSupSul+iLbvQBBvxCd21/omLHdrOx99H9mFnkk/DiMzhwv0j/32wb4YnyBXVY0YcU0E0yPsVQWCdDoz5BR82rREjB48kb4PvVfnC/RVFbGo1CBZppn6JfKMEVHgh49bq4GUzju7C9dkeK6k+EeZFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770297; c=relaxed/simple;
	bh=ggVAIA2sklo26C9Otz288zpkz5G4DsOLLNzvqX2b/Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXg+kSMRicFZrSgh7Oc/yABraz1l6jtrDt7d2H0WxwTPwxhPv1DIFzE684QdhQoZsnys314ie02CQkQr6svHx0O3YOnHpUPBdyp4QZ8pXoTGiePvaPPHzQOMoIckRlfwz0vGOvueUWE0jQlxjcJU1z+uEQRcmFkJvDul6Z7EtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgkq7vbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgkq7vbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660FF1F000FF;
	Wed, 30 Sep 2026 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790770295;
	bh=ggVAIA2sklo26C9Otz288zpkz5G4DsOLLNzvqX2b/Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dgkq7vbH6iuUzbjuylfytcS5yxD3rIOJNZhiLtrf3pZ5RqbPANHofyLv8z32oVlZD
	 kb6w4Lh30KCwKW0+474FKeAlGGS6TlsV32FcwgiHvxblgHKp4igQdE8R9vVD5Z1qET
	 cKkC2/iWQ5UwUaL704IInXn/CdNJ4aOufJ2huKOxLnUjeVB2chDHPpb8uUuWd68Wwf
	 eenUMpMbt7ybdsG80FZaOSqq7PEqpDSb/y5pUcP1VaZ+PqE/WGOIPhPW3/S99XJnoE
	 qLHNU4G5LVQgXfg85M8+MAY1oMnY8VkXhm7XKaRDa3cBSGbsHp3QQ08+HR298m9Tr2
	 1S9ekVyRjwNAw==
Date: Wed, 30 Sep 2026 13:11:30 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: =?utf-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
Message-ID: <arz8Plu6J4YOTi0a@gremlin>
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org>
 <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
 <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org>
 <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arz0auULA33fqoWu@gremlin>

On Wed, Sep 30, 2026 at 01:08:33PM +0100, Lorenzo Stoakes (ARM) wrote:
> I'd say in general the shape of the solution would be something
> cgroups-ish, but since all of this is global stuff and the knobs are all
> global I think you need to think about your design a little more.

(Sorry to be clear, this is - if we accepted that this was a kernel issue that
truly needed something like this - which I do not. The solution here is to use
shared memory as per below.)

> And in general we've seen a pattern of 'writes to MAP_SHARED, experiences
> problems' before.
>
> And the solution is generally - use something like memfd, have a process
> that does writebacks manually for you as you need.
>
> So I strongly suggest you do that! :)
>
> --
> Cheers, Lorenzo

--
Cheers, Lorenzo
