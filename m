Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23E47278D;
	Tue, 18 Aug 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058456; cv=none; b=JFkpCIUH21Ly7q3O6gNdfQfKEZRKs3tp3hVmpcpTHDU68Ueq4GpvrjcfinFe0d0H2m2+47J51XILapCGgMMGnoVxGMe7+SIMdEMkeggusSuKSMk84d4Rzo2QeLrIUBZCEQV5oybSyJ9uOvYx7azFV3f6Um9y6M2zCx8pdddt44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058456; c=relaxed/simple;
	bh=hWgSgoBs/yty0/b4V61v8tTj+E/PPiW3Y73aLv1hWjk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eUTZFpC46FhMLLvmAx0zKWccWucskPzq3JsbmML6OGCC0gRX9xInTF00XOOisz9QXZEa8wGFnjxHwTUFHEQ4Dzt3n15ECWNjzOkaHuqRmGClwAVVp66Ov4qCl7wNLKkruKUO2S/k6SVjsImJdJylvGl1Sk6T3IMpWlAXt0m0mlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=ssVyY3sc; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="ssVyY3sc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787058451;
	bh=d+FrlVBFSxRPONQ0ZzFJrYgl97w5FLa5RJAF4PEgUfs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ssVyY3sc19bJ6q5l2YmHLAdN0vBOZKLOUyX3lHHwn532OcT974Lhkt1afyooIleJU
	 /NOwFLmzS9yNHvkKXj7OV6bSJnA0aJqcYFF1ZUt5+wKDTzNNxOFL+8kioGCANJ7iqq
	 hBdDOrX8umcjgN1U7E6dC1b1OlHSkMpcX/qsoX9c=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hPVNg0vyyz6vKm;
	Tue, 18 Aug 2026 13:07:31 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hPVNf5BfMz4y6W;
	Tue, 18 Aug 2026 13:07:30 +0000 (UTC)
Date: Tue, 18 Aug 2026 14:07:30 +0100
From: Bradley Morgan <include@grrlz.net>
To: Joel Granados <joel.granados@kernel.org>
CC: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com,
 kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shijianlin11@foxmail.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/4=5D_sysctl=3A_Disallow_partia?=
 =?US-ASCII?Q?l_updates_of_miss-formatted_sysctl_vectors?=
In-Reply-To: <4hbx4orb23mruq4dsjolglzgsjue5g25bbmnbeu5w37x7em4rm@o4hp6nu54ye6>
References: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org> <5F021629-DD85-4941-8263-3C4F51E9D6BD@grrlz.net> <4hbx4orb23mruq4dsjolglzgsjue5g25bbmnbeu5w37x7em4rm@o4hp6nu54ye6>
Message-ID: <9335573F-07B4-46EF-B947-502A118AC2AA@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 18 August 2026 13:46:58 BST, Joel Granados <joel.granados@kernel.org>
wrote:
>On Sat, Aug 15, 2026 at 05:09:30PM +0100, Bradley Morgan wrote:
>> 
>> Copy it, only write back once every value converted. That's the
>> right way to do this. Went through the whole series against the
>> tree, notes in the patch replies.
>Your feedback was useful, but it was riddled with a *lot* of hand
>waving. Please be succinct and to the point. The previous paragraph is
>not needed.
>
>> 
>> Some nits on the series:
>> - "miss-formatted" in the subject. mis-formatted, or just malformed.
>Note that this comment is missing the why. It is good to know why you
>want the change
>
>> - akpm's scalars nit still applies.
>> - Sashiko saw something on this one (akpm linked it).
>In my opinion this is just noise. If you see that I have missed a
>comment, call me out on it. If you have additional information, answer
>to reviewers mail. 
>
>> 
>> Otherwise fine by me, the split is clean.
>> 
>> 
>> Reviewed-by: Bradley Morgan <include@grrlz.net>
>> also
>> 
>> Tested-by: Bradley Morgan <include@grrlz.net> for the test
>How did you test? And what where your results?
>

Built and booted the latest kernel. Its the summer holidays, I can do all
this, it's magical

>Best
>

Thanks!
