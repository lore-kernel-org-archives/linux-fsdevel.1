Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650322;
	b=mC91d62GRUfboAzcr0mCMJCmdKiM8fJs9jhimTXzqdgM9K9K3Mt2WzxM2pPjEVSNQvWc
	 dT2HA4l9y27+aggi9+2KwzmcaG50u8MWwHgmGz0tcpAAjdQ86KXXzdGktXwYg5fzqcQzp
	 8SCVpY+q32hDPMNJCvQ/7/R+uhbooKF3SqTxH8Rqy829C+BYf4cf/yep+uBoDWORk4VLx
	 eGiWLQ1PgzJytBfpWGettgm92r67DVjOAN/Q/HeKKBL0YtNZuvRbMJOgAm+DYQxZlSBZM
	 0gcGFDYjTFtfFPkT5ESwMUXJz9cCJ8cFXI0aPTZNLl0Wm1yzZ09bMYaoMS2S8/nrbKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650322;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BjDOfNesHUvUYdnemATt3QpEnFnBaEWBJAu+ke/IeV8=;
	b=B5bCoxJP5X41L5TjJf3sEnGK2IdduH36mq+VK9J0Fpg7e/aAiUVJ/CUesPBF22YFFgs4
	 Z21KKeDiSrJ+yX4YkJAo1ssdyC2GFoJ5WDNcTjresN4H98LlQ21wtspTLXxt3M05fY1ga
	 KMXoRhDuxK3pGo3CRHAXWLTCeP0Zf7cGPnBl8PhA+pFCnIF9nFDACMS8JD3gsiIGFE7MM
	 zc/AzDYyrGsXfezMxpgXGC5tWJ1ZCzh99o3vjIDrwdaLRv+bGmXXXC41aZ4MfaJfrh+dl
	 zX2pY5BB8k9U2TLc0zQdVk4RKQhG33gYMNVSTUI9vGKNGguC59OdisEIl4XhfIYKp1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fCxM4P/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08F606A331
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCxM4P/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9281F00A1E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 20:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650322;
	bh=BjDOfNesHUvUYdnemATt3QpEnFnBaEWBJAu+ke/IeV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fCxM4P/Z77JCfIGz5fMLuOcLnuT1agPgyAWc6xu2TroXoThnXAKIo865OA4e3Atv3
	 Xkbwhl0CojTtI2yoq5c7Ln2KnHGFmGHgwzv6SP3jZiYjGo05bpiahvSpZvouEqDM1B
	 rvqYc/e+G6siNDWSVM6h3lJqavfaFQiVLKyFwINS1Vkb13+CyUgFRYin3AIZAZzbOD
	 mWQknHNoyjII2fneg/H+qwzDuHAE6uAHVcoEayLt2p2bHySptfg8+s2a1IeQepo9V2
	 sE1VX0Fqw64Kk1PPou/Tb3RUpSk/a3yHnCuZLrY9FbX08LvaQsS19YXd7j9hMua/Fd
	 wH3o5lWXSGCVA==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91b52ba422cso46826596d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 12:12:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBySkzwhQQIuHW4MXFtbSgkyy2HFWIu3RTRsT8TNmVv5W8xxq+oXxbVamUpEZ2dzB3/kWIIsXuJl8RE5mRIB@vger.kernel.org
X-Gm-Message-State: AFq9FYI7HsStCvgPgLKYpygVpq1et8SMY/klsY9kJA3PlFEELnl52Sdw
	/zNcbX6ImRLUes9DOzGfNSuedVgYJyWlNDnX7Uq6NS4RVj4KVECoLePLxIoLtNXq1/jxxuQ5d6M
	0uEC1ittTcpuxs2/a9Pw3sgEq5qMTae0=
X-Received: by 2002:a05:620a:2614:b0:93f:baf:279e with SMTP id
 af79cd13be357-94421588032mr1947387285a.8.1793650320775; Mon, 02 Nov 2026
 12:12:00 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
 <20261031055838.60138-1-lance.yang@linux.dev> <a704d458-ad60-43bf-a0ce-3b128b218d88@kernel.org>
In-Reply-To: <a704d458-ad60-43bf-a0ce-3b128b218d88@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Tue, 3 Nov 2026 04:11:47 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wjGjDoFPz3qWHqW8WTv31AkR_zrY14ON0dLbTZNsohWQ@mail.gmail.com>
X-Gm-Features: AclHuK_rJzE5Yay_lHuYFvz2Gw1cEWyIS737R4EkfHxGw2G6SeGPSgpipiW_eIU
Message-ID: <CAGsJ_4wjGjDoFPz3qWHqW8WTv31AkR_zrY14ON0dLbTZNsohWQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, muchun.song@linux.dev, kasong@tencent.com, 
	ridong.chen@linux.dev, sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	kees@kernel.org, peterz@infradead.org, jannh@google.com, pfalcato@suse.de, 
	hughd@google.com, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	willy@infradead.org, jack@suse.cz, ziy@nvidia.com, riel@surriel.com, 
	harry@kernel.org, apopple@nvidia.com, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, usama.arif@linux.dev, kas@kernel.org, 
	matthew.brost@intel.com, jhubbard@nvidia.com, peterx@redhat.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	osalvador@suse.de, minchan@kernel.org, xu.xin@linux.dev, 
	chengming.zhou@linux.dev, chrisl@kernel.org, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, youngjun.park@lge.com, gourry@gourry.net, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com, 
	jgg@ziepe.ca, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, josef@toxicpanda.com, 
	stable@vger.kernel.org, usama.anjum@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 5:42=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/31/26 06:58, Lance Yang wrote:
> >
> > On Sat, Oct 31, 2026 at 09:46:37AM +0800, Muchun Song wrote:
> >>
> >>
> >>>
> >>>
> >>>
> >>> Agreed. FWIW, I think Barry Song and Kairui Song would be good candid=
ates
> >>> for the maintainer role.
> >>
> >> +1
> >>
> >> It would be great if they could take this over.
> >
> > +1 from me too ;)
> >
> > They both have been really active on MGLRU and doing great work for qui=
te
> > a while. No doubt they'll continue to do so :D
>
> Fully agreed, we really need some people familiar with this code to help
> maintain it, and Kairu and Barry have most experience on this.

Thanks to Ridong, Muchun, Lance, and David for all the
kind words. Your encouragement is truly inspiring!

>
> Just a note that I also don't want to pressure into such a role (which co=
mes
> with responsibility).

It would be a great pleasure to work for the MGLRU
community.

Over the past few months, we've seen many active
contributors join the MGLRU effort. It feels like MGLRU
has never been this popular. I'm really glad to see the
community growing.

I may have missed someone, but besides Kairui and me, I'd
like to mention Baoquan, Baolin, Hui Zhu, Ridong, Kunwu,
Maxim, T.J., Siddharth, Xiang Liu, Bingfang Guo, Shakeel,
Zicheng, and many others.

It's great to see so many people contributing to MGLRU!

Best,
Barry
