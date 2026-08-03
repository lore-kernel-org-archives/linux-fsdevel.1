Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA842C4FE
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785816845; cv=none; b=g/JuEWauANTi7FrVK4jF01gPSNfDqVPu7oEeIWFAeIRXWSWSTigjqEufoExvR2wsFEVUpv4OCPEqABy/pS4mSzi+yaDJFboSkeIqAcQzk0fyJmxuRvfVyQuVDdmByyXXoStoNbFwZIfQr5ZnSAeDWNSzpgzUZZyTE5dShS42poQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785816845; c=relaxed/simple;
	bh=QgyXbajf8k1ouWp76clM/q24oXyH9GRpwK55eN5BX+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYljs5w4SMIMlkaOHvsXWsxu9lO2Xsfqy3VnjzCQAFxGhQYwWMqySB5MutlzgE6ZTwU/vHLFbcmysL+tA/sLcfd16Aj/n2alwFvOE6GGZEEXEg/8ih21kKUQkxi3pxbtMJ+/pMb9bwV+2NhwdMSex21pJXS3yX/NKkXxA9iFVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XZGsiXYc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XZGsiXYc"
Message-ID: <b4eb8a90-d11e-4992-87d2-99091d4aafd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785774947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkrn64K2O1qrTL7hm4UrLcILaI10/JPPjTcY5a64cWM=;
	b=XZGsiXYcTF3XNAplQQEQg5zT+sto4CSZeNb19L2IxkUDWNIpEz84q8NdGbCovZiM0sDaFf
	GOGvaUr8LlxoRwpuB3LdqCZ5xg88BASLPs4bE6YurjydslxV9RK5vE3BzsOrrdMnfQAHAf
	Tc67SMfPGB2odqYPxVlGOnWyuJpvQYg=
Date: Mon, 3 Aug 2026 17:35:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] squashfs: avoid thundering-herd cache wakeups
To: Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, squashfs-devel@lists.sourceforge.net
Cc: brauner@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 jlayton@kernel.org, boris@bur.io, riel@surriel.com, kernel-team@meta.com
References: <20260724190556.1950693-1-usama.arif@linux.dev>
 <664bff99-ef20-44b9-9c5f-aa6c8755133e@linux.dev>
 <20f40e87-02b8-4714-b417-2730f304d624@squashfs.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20f40e87-02b8-4714-b417-2730f304d624@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 03/08/2026 15:43, Phillip Lougher wrote:
> On 03/08/2026 11:16, Usama Arif wrote:
>>
> 
>>
>> Hi,
>>
>> Just wanted to check if there are any reviews or comments on this patch?
>>
>> It is attempting to solvie a real thundering herd problem we see in our fleet.
>> It also doubles throughput for small file reads and stat for squashfs.
>>
>> Thanks,
>> Usama
>>
>>
> 
> I have been on vacation.  I will review it this week.
> 
No worries! Thank you!

Usama
