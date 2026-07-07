Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29612D3733
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411820; cv=none; b=Lm22IPte775/dShzNWY8qqFiy6Ua39UOnkLaGDzmpM05Ipqzuowsh50TX1NHF1WwfOSESFQWQgamY3oUb94J2yWnk3RKqKbzt+fxITXDuE1mg6jVGiS+KQuYuABlxHp3fbdWP6m+AO6o1XhEbflYU9voeLV6ehlT14czG6H44Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411820; c=relaxed/simple;
	bh=JoijE4uJCyq2j4khlPNuxF9JMy8fYGszG7NSw2HhBR4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tR6BYzrEo0wRzcpQ+28pyEiNd9zwT6ec4OK0qv2xW1gnzzv6ZIOQgLixETsLj+Ih9pTUvxfuuOcUvAtyLjjVd6anGQW9kyfdxWMNTsDZNSjJjl3U73TiOTox/adt/votesvx+NkvNj0nLkzbKNrFqh9lDGgygRKwoQH6NV0Ku14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mr2sA5O2; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mr2sA5O2"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783411814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoijE4uJCyq2j4khlPNuxF9JMy8fYGszG7NSw2HhBR4=;
	b=Mr2sA5O2fwOZH+tdJVJbtFshcbUt3g6menEXK/k6fjP66J6bIxXN/uaF0WmGzyaLj2b2VW
	cY7kl73i6uSScBXlAmniWx4i6iDgVdgQJxt9MsQIpFlyQva0MSuZ1QtqGe3FGadARI53GI
	anr7Vxi7SJDpzawCZrnJt5t0V6M76zg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [RFC PATCH 0/6] mm/hugetlb: Dynamic, NUMA-aware HugePage Cache &
 Free Page Reporting
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <9624988a-366e-4884-9408-3f3b88c27290@kernel.org>
Date: Tue, 7 Jul 2026 16:09:35 +0800
Cc: Sourav Panda <souravpanda@google.com>,
 osalvador@suse.de,
 akpm@linux-foundation.org,
 ljs@kernel.org,
 liam@infradead.org,
 vbabka@kernel.org,
 rppt@kernel.org,
 surenb@google.com,
 mhocko@suse.com,
 mst@redhat.com,
 mhklinux@outlook.com,
 fvdl@google.com,
 gthelen@google.com,
 mike.kravetz@oracle.com,
 pasha.tatashin@soleen.com,
 rientjes@google.com,
 riel@surriel.com,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <48E0B0E2-4CE2-40B5-A7C3-9DEEF9F49C41@linux.dev>
References: <20260707064235.1386552-1-souravpanda@google.com>
 <9624988a-366e-4884-9408-3f3b88c27290@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jul 7, 2026, at 15:29, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 7/7/26 08:42, Sourav Panda wrote:
>> Overview
>> This patch series introduces a dynamic, NUMA-aware HugePage Cache,
>> backed by a kernel shrinker to safely return memory under pressure, =
and
>> integrates it with Free Page Reporting (virtio-balloon) for HugeTLB,
>> specifically targeting gigantic (1GB) hugepages. The goal is to solve
>> the tradeoff between allocation latency and memory
>> fungibility in virtualized and heterogeneous cloud environments.
>=20
> Hi,
>=20
> in general, we consider hugetlb nowadays to be mostly in feature =
freeze, as we
> realized a while ago that adding more special casing on top of =
something too
> special for all of MM is only going to hurt us more in the long run.
>=20
> We want to have less special casing and less special sauce, not more.
>=20
> Now, there is nothing wrong in making hugetlb be less special, by =
making it use
> more of core infrastructure etc.

+1

HugeTLB is already complex today, and the last thing we want is to =
compound
this complexity by piling more features on top of it. I fully share your =
view
that we should avoid going down this direction.

Thanks,
Muchun

>=20
> But optimizing for surplus hugetlb pages by teaching hugetlb about new =
caches
> and its custom free-page-reporting support rather looks like the wrong =
direction
> for me?
>=20
> --=20
> Cheers,
>=20
> David

