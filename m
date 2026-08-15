Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F1361656;
	Sat, 15 Aug 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809935; cv=none; b=u16UBrQuUQEd630GHt6FSZ/9q71EDUdEjbA8NJpMt9BSV8g+7/c829caiWgH52T23UkNlMqi3O4MMjmKE14hZnoM3gGHnh9Bzu8v9FL21fC72q9LxTiiwgpRiT20i8FoobGGAGYDKs5DGbsoH8cf3adLPnHiczuduGSMlDnTqS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809935; c=relaxed/simple;
	bh=C/2w3Fzs1DPhm/TJwzhpkL8Eiva07UXknvWOLY4BdGk=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=BbXZ1tNSoEkawl5mjobvVW9dWX+KKWHBseoeuAGr/rhmV4OLLvSFOIe10q6N3ALInjUJgivptv0b9uLXm+g5dzReL9IbUCQXTllYagoJ11FUrWd4M99QUwBOfStJrVEF8PURv6V9d2asJhl/14+6DHBNRzcFhRlCxo+u5ubW49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=X9w8gER7; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="X9w8gER7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786809928;
	bh=C/2w3Fzs1DPhm/TJwzhpkL8Eiva07UXknvWOLY4BdGk=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=X9w8gER7OPQlnLdr12Ir6s+Ri74wI4h5Zz3/VwM2A5ifbB3VahEljU8lDBV0zr4Qw
	 dtADfdcl1m+rLYCvvJ/mcRt38ancNsWyKg/A+6RWnjnEYuQycknz1pg8gA9uBI9/g8
	 +FTyAukfHIf5Y6l+GGa8BSfQDZKAdCttljj73y/0=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hMkTN6hwzz6vKd;
	Sat, 15 Aug 2026 16:05:28 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hMkTN39jLz4y6W;
	Sat, 15 Aug 2026 16:05:28 +0000 (UTC)
Date: Sat, 15 Aug 2026 17:05:26 +0100
From: Bradley Morgan <include@grrlz.net>
To: joel.granados@kernel.org
CC: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com,
 kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shijianlin11@foxmail.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/4=5D_sysctl=3A_Disallow_part?=
 =?US-ASCII?Q?ial_updates_for_erroneous_sysctl_vectors?=
In-Reply-To: <20260814-lklm-partial_ctlvec-v2-3-9df50d26e477@kernel.org>
Message-ID: <3A4FCA2B-2F42-4E8F-A328-5C1BD658B2A8@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

commit_conv_vec() writes the elements one by one, so a reader can
still see a mix of old and new values while the loop runs. Same as
before this series, so no regression, but the changelog could say
this doesn't make the write atomic either. Otherwise someone later
will expect the vector to change all at once.

The copy is limited by table->maxlen and only vectors pay for it.

Fine by me.

Reviewed-by: Bradley Morgan <include@grrlz.net>
Thanks!
