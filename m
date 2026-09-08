Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072C582B9B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888171; cv=none; b=F0uRbXai2JN6q3xWDcaS+Z/LkkdHurVivFlFKM6IpEQK1vRdIflcU8/59QVxuzis4VBJhn+4EyNLtliQ8M08g+LrkjQbI4DChe45TG2mbJXC5w/CtjBFIay8RFwPTBHZJtChHpknQvIbomYr4D/lPbr2NKEL/2jSVm74cjfhoI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888171; c=relaxed/simple;
	bh=iIDmJNb11eoTyAswBi6a4H7EY4/KrlwHeNNC9qvH6Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTBV3m7duUVeYWH4wVEEVyl2Q7JR/9a4JD1bpjwHLLEQiWKyzHjFGY538K5IBErS32OkipW+oMQ3KLKYmPUoqJfOaCHvFJwMfewAHg+jBqGFWwvQ/aIEVTLdSjYUifSjd3tgv18lyPZS8E66JQEBeyj3vucZH2/sdD8/PJqQ72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAu2zPbj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAu2zPbj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48441a2ba14so4139972f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888168; x=1789492968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CPQ/tJ9aUOFnRHS3Svdi/PSdSnzgIKh4Q2Uv7YT8iUc=;
        b=tAu2zPbj+7RlbYKfk00/G4dZflzYKr75tDdIeBibhm/4cZI9WvWyGKVJ1p282ELRFK
         Bq/sVIrAW2I9YjjBZb0k3Rq/evRTRPsaS/hpa3aSNTFkOP3d6l04tLDDHhlRCgAFjyfU
         pUghuUik+0fvfIHzmDTrMdy2cr1NCCJE4no4kHrDpV32k2JNxGJ816oLFgLc9zUXT8mU
         yoFUmnxuAR6DoyDRo/gCHef7kXi0MXquEX/zNzyOfb6jJX4ne7U8C/e4XmHk78A2VYw+
         O3Q01mNhjEd+ZXAQ4MLEXWcKTdoe5jt5tauVgBKiMw3GHosoIfQKX19KAca/kX3OlSDM
         WKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888168; x=1789492968;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPQ/tJ9aUOFnRHS3Svdi/PSdSnzgIKh4Q2Uv7YT8iUc=;
        b=J/ogHcnAHmyADjeXFiL9lVyO67vaH39UeXSHkmj62ceTFp7JZ8UNVymW+SouehSmSW
         ltxjS8KuEhke9LAeWCHpBrZ3GgtQOpzLunRumpXImg/xIYWP41W+SDILAyqCiQPORv+5
         +1cJ+UWnA/3wUDU0W70OREVojhNGgp3HTTpp5XSqhSOOazeSdx3HXbSyTyCZVGk+8d6D
         k1/0NzrBxT+0vPXMnJoQF+qy4BZG8nAez7G4yEMrE2E4pDVDtEsarmxHKOQr6C7OAb+q
         Zy9Fwqr4p3KMSCIdpHyx7Xuua7EttbqE0rCbndPUdnGZxVl844KcongFuGXRQN9p0Kny
         TGWA==
X-Forwarded-Encrypted: i=1; AKwUvBy1IsN9i0IRDzk+EIzUmdGS9GOwrO4qTiP6o7o1769ld0ii+ZyAw0WCgdJUmblKXPg/SU5Kwo+aHWuT1j9F@vger.kernel.org
X-Gm-Message-State: AFuF++mzLeECscQAGdC3qu7s5QIz98jUvPFldK+J1j9dXArpvHkS44xu
	LViZ5LJffeGmnFZiPoWUAhZ671moDFJWs5LfwNCshEwxSJybqe/YMYE=
X-Gm-Gg: AYBFou05jIlB86vDa2NbF4FEO8ltV8xyzs5RKlfeTeHfhnnd6wSOorbwxTJmyvjgbPn
	NnDRbyNaazrnYxY3g//A9F4F8hSEqezFUFz68qPsQlMXfRd+G6x2r1MCkaXq78ZXt/qD3b5KVHk
	F7pr9EtqZ/+WQojJZWOozHVZIpwNBB1jAwAIUUVtwLPcKgRisf0Az5HJIFz89AIk+SnX9yTJE7u
	yyWny0bVKT88czvkrc+HsQQyynh+6mOwcZ34bnUW7g75gtd52PWh42r6HeAcCtmvLDMqZOOuK6Q
	fi+OYy5m0smZuAPIMLw2ksxdn27Nukj1s8z2VhFE1If3QQNJCqQdVmkm0B6sgWbwUFBL3t3eIAt
	pQeR5KIn4QMyyvuV1u4N++fQ+K/e62QpbrmmkF711h39RmVEhc4vLsfISq0kY/owKSPr+ZPw/w+
	KHu8vzgdyGnzA/x9nH1RAaf9SVxoBlxdCD3Prfs+agaU6HFkWXaYgNI+1D0j/E
X-Received: by 2002:a05:6000:1acf:b0:485:8a46:7062 with SMTP id ffacd0b85a97d-4858a467220mr28481744f8f.52.1788888168285;
        Tue, 08 Sep 2026 10:22:48 -0700 (PDT)
Received: from p183 ([178.172.147.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588392b3esm42740507f8f.12.2026.09.08.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:22:47 -0700 (PDT)
Date: Tue, 8 Sep 2026 20:26:54 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Ye Liu <ye.liu@linux.dev>, Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	"David Hildenbrand (arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Ye Liu <liuye@kylinos.cn>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/8] fs: convert process/thread iterators to
 for_each_*_rcu
Message-ID: <16df546d-46b5-42c1-a8ca-24cde0051a97@p183>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-7-ye.liu@linux.dev>
 <662ade9d-d662-4f6f-869f-08c41da53170@p183>
 <aqBBFAiMG1NQITkz@gremlin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqBBFAiMG1NQITkz@gremlin>

On Tue, Sep 08, 2026 at 06:10:17PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Sep 08, 2026 at 07:45:15PM +0300, Alexey Dobriyan wrote:
> > On Fri, Sep 04, 2026 at 04:29:58PM +0800, Ye Liu wrote:
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> > >  	if (mm) {
> > >  		struct task_struct *p;
> > >
> > > -		rcu_read_lock();
> > > -		for_each_process(p) {
> > > +		for_each_process_rcu(p) {
> > >  			if (same_thread_group(task, p))
> > >  				continue;
> > >
> > > @@ -1177,7 +1176,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> > >  			}
> > >  			task_unlock(p);
> > >  		}
> > > -		rcu_read_unlock();
> > >  		mmdrop(mm);
> > >  	}
> > >  err_unlock:
> >
> > What's going on here?
> > Now it's RCU unlock after mmdrop().
> 
> No it's not, scoped_guard() is scoped to the for_each_process_rcu() block which
> ends before mmdrop(), i.e. the exact same scope as before.
> 
> That closing '}' is attached to the if (mm).

OK.

I think naming (and macro) are misguided:
* _rcu means "use under RCU section opened elsewhere",
  this one is "I open and close RCU section myself".

* not every 2 lines should be combined into new interface.
