Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30733D7D8D;
	Mon, 17 Aug 2026 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974370; cv=none; b=kNoaK+aSrn7YaFjGV/bCvzt6DP2DsMaAX+arXli05XD+FwTj76WPLlTERNlK4Bb3qp094rbfLb+4lanyxLhAj1tQrqne1Up/UhiXoCydMeresmt3mKtpbaAQ69QM8kWT04uaE7hoos+jiMAxVLwVpz1N1IhZDbtXbh81lZBriEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974370; c=relaxed/simple;
	bh=az34s4xk1pg1ibnyNYN66Ui0rgPsGjKvJKQRxku/Oto=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NQn/srZqqwkvGUS4GFK51PXlvDwKVa7sewzHTnY8NA/WNwdVKKSgylyxBOH5I7KOgaG4ftq9CnOJ1YyJL8hN36SVjtB43lgHokKkikR8h4pWHJDVXGr25FjcDvpx5wJD6skRx4i+jqZ4gc8ggAkz+Jed1iedmaRaDzWiP/U1P4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=AGIu3f6g; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="AGIu3f6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786974361;
	bh=ig8b2sENsh4uRBZuRVMIOvnD2w3jOwT8EfqPmaadLzY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AGIu3f6giLeq5unMffhjmaNuwQG+K2BpF+4ytiFS5wBUFnwDpoT+5nKLTQJTcVHJK
	 yYdVw8LyfbYpRLhrJnEsl/O0xUCrbegGEAZasN7B+G4R6eRWhVnK7m60ZMrGZeEy1H
	 ejUPu3tHSjFbEv3BRigCKoZeM2H/gKBXAS9wGIfk=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hNvHY3gdZz6vL2;
	Mon, 17 Aug 2026 13:46:01 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hNvHY0Chmz4y6W;
	Mon, 17 Aug 2026 13:46:00 +0000 (UTC)
Date: Mon, 17 Aug 2026 14:46:02 +0100
From: Bradley Morgan <include@grrlz.net>
To: Joel Granados <joel.granados@kernel.org>
CC: akpm@linux-foundation.org, hannes@cmpxchg.org, kees@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shijianlin11@foxmail.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/4=5D_sysctl=3A_Disallow_part?=
 =?US-ASCII?Q?ial_updates_for_erroneous_sysctl_vectors?=
In-Reply-To: <FB1BAD61-3BC2-4CF0-9345-6CC2E9EC548A@grrlz.net>
References: <20260814-lklm-partial_ctlvec-v2-3-9df50d26e477@kernel.org> <3A4FCA2B-2F42-4E8F-A328-5C1BD658B2A8@grrlz.net> <cwfpl5h47km6f35m5k7wa2pj3elciaax6i3nmetxcgws66qewq@fzygztolxed4> <FB1BAD61-3BC2-4CF0-9345-6CC2E9EC548A@grrlz.net>
Message-ID: <C95DE45D-776A-4856-808F-936D7642756E@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 August 2026 14:44:29 BST, Bradley Morgan <include@grrlz.net> wrote:
>On 17 August 2026 14:43:44 BST, Joel Granados <joel.granados@kernel.org>
>wrote:
>>On Sat, Aug 15, 2026 at 05:05:26PM +0100, Bradley Morgan wrote:
>>> commit_conv_vec() writes the elements one by one, so a reader can
>>> still see a mix of old and new values while the loop runs. Same as
>>> before this series, so no regression, but the changelog could say
>>> this doesn't make the write atomic either. Otherwise someone later
>>> will expect the vector to change all at once.
>>
>>Seems reasonable: here is what I added to the commit message:
>>
>>
>>"
>>... This (The staging vector) does **not** make the write atomic as a
>>reader
>>can still see a partially updated vector.
>>
>
>Good enough.
>


Hmm. Removed a folk off CC:


** Address not found **

Your message wasn't delivered to jackmanb@google.com because the address
couldn't be found, or is unable to receive mail.

Learn more here: https://support.google.com/mail/?p=NoSuchUser

The response was:

The email account that you tried to reach does not exist. Please try
double-checking the recipient's email address for typos or unnecessary
spaces. For more information, go to
https://support.google.com/mail/?p=NoSuchUser

:(

>
>>...
>>"
>>
>>Best
>>
>>Joel
>>
>>> 
>>> The copy is limited by table->maxlen and only vectors pay for it.
>>> 
>>> Fine by me.
>>> 
>>> Reviewed-by: Bradley Morgan <include@grrlz.net>
>>> Thanks!
>>
>
>Thanks!

Thanks!
