Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322370;
	b=exTEJ+8rDxbvJzUrHhyqa68vcK+Pu2hu+8MlVQnfouBN5CT+yrNrgY5QUaM/aO9bn38X
	 GykGeK8BKl5zZ2N8u4YLN+KCAV8hj5X/2S45rM5tf/qbzqjup7g9tRxwmyOEp9PBzEg2+
	 L97aoAtDuk1RJmCKr+0fXvAJ2mOduDxY34Xa7JiJtDiL7k5bEt3lj7DLZ01/OLZ0OaEBa
	 CB1+Ql+AGx+vbblGW9UuoqqZtwS4ZOm4cx9H59cgq2J1TFkFYI7YyOGezn2T0ONBqg4PX
	 1/+9v/W0U65T9DDL/YIm3QBZ3ueg2tdpjZvB1txKTO0TuH+XFf6r3VEJg1BpN5cEIRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322370;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KjNKU0fVTO1GwsQf4N77ndWDLlPg8PdsmZT2hfApWPE=;
	b=kzY1HkkCKnG3c9eLAM/Bkxs0cvxgSj53utF5Ow4HjH9xaXfAQS00XS7O9j2kLkNr73g7
	 gEvZ8yDblEoOVrQVVJrtsrK8jOZt4UYhZ2J6PglU6rHUZmlCEiixX/jan+ZmLkeoPT0T4
	 WbUbbpi6ytgPDBglL73guPpsrIeVWahkvvNEDj3QUc5rSR/MOMh8i+Yu09QUMR5QSTJTq
	 gLvfrdIACxqGJCcx352vZc82ENfg5p5LsXbb5ZgXj44BuDWUzMQOYjLxvHWXesx2s1Uon
	 TQtbDsjVPVDwOWhx5t3CV/Wshm6FhzGSmfU0NI35t0uP56/IK9iV9W5IHmcaunWyKIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ir9ZLK3P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0F606A31C;
	Tue, 10 Nov 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ir9ZLK3P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E291F0089F;
	Tue, 10 Nov 2026 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322370;
	bh=KjNKU0fVTO1GwsQf4N77ndWDLlPg8PdsmZT2hfApWPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ir9ZLK3PpkfzDHwBcrLGOXj9EpS3CyRkUiWe2WwPnXWGe9MH7GhS0D6BtRe4YJbHS
	 BPWDdz6H34G8sRDEWFesNvtxhFSktyx4dL89CZlAObyY2+4zj+YpmdRZE4zYPYzlJN
	 EL7RwDR/T7DATHbxcGSS8hRjxDb316TtTTckKTKgWIK4iGZCB98im3bPBJB5r0hb7L
	 VsHPwUXFS83jzWgZtIgh/mqO7VaoEDxb5nwxXqHePDGnZbghwcb+WtWNAhpRPlFWH0
	 jGV9L3oUmue0lg5M7GyOBz+3YXmbdy++CeGlfIg/huEG/6o8pU9vyl5gl+SzYbNO0K
	 hFyUOG4XEhrfQ==
Date: Tue, 10 Nov 2026 14:52:43 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Seunghyun An <san55@wisc.edu>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Suren Baghdasaryan <surenb@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm: avoid redundant reads of the vm_refcnt cacheline
 in anonymous faults
Message-ID: <avMvlLOaByIc7SWj@gremlin>
References: <20261110000002.1834454-1-san55@wisc.edu>
 <avLxcf8KaFP_XPnM@gremlin>
 <MN2PR06MB66398F39E876279DA2CA8A52D2722@MN2PR06MB6639.namprd06.prod.outlook.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR06MB66398F39E876279DA2CA8A52D2722@MN2PR06MB6639.namprd06.prod.outlook.com>

On Tue, Nov 10, 2026 at 02:34:31PM +0000, Seunghyun An wrote:
> Thanks for taking this on.
>
> I should have disclosed the LLM involvement up front, and I'm sorry
> I didn't. I came across this while researching the performance of the
> anonymous fault path and worked with Claude to investigate and quantify
> it. Claude also drafted the code and changelogs.
>
> My main aim was to report the findings to the community. In hindsight,
> a plain report would have been a better way to raise it. I wanted to share
> the measured effects, especially on EPYC given the higher cross-CCD
> coherency penalty, and offer a possible way to address them.
>
> I'd be glad to collaborate on measurements for your series and any
> follow-up work in this area.

Thanks! I will cc- you on the patch, and if there is any remaining issue we can
chase that down.

And of course credit you on the patch as reporter! :)

--
Cheers, Lorenzo
