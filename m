Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C239657D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164736; cv=none; b=IvuGL93DGlIHurXzZj/WqyfxHxdycktKGaPXd9/LM44G5OBLSpf+Om8FqX6Sgtke674++lS/IrVbKp20vmWVjmqtR8Quz58FBBtk+RPojca8OSi8DAmza8VuJ1X+NH5fDKKqumJa6Mgd9N/6OrC7dl75DjfI95X/YkVZ8fldB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164736; c=relaxed/simple;
	bh=wIeMCxoC+Sd8fCqUOC74qjZop1Q+zylVlZGsYVa6v58=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uBfgdQu+rf/X9hrHvg4uDCRYtOGQhsv5g2d6qRlbOkxNM1lm0T10qgY2dFA/4+wCRwd39Amyly8lV+j6R2IP4wXHlBd5HMdOktpiGK42/nORzEDMJ+RBLb8vxzOC0TPrj8sPjIv9Keg9J6xgkj1DASipTM9Zz/yElR1P9x6WKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=kSdQmc1s; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="kSdQmc1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1776164734;
 bh=thsSuf+oHeIhjdYQIbRCCQ2HYNoEGP9AGMl+UslUno8=;
 b=kSdQmc1sUWf77wgXLTetBlwA2Vguo+swfh1MaVm27fljhKsshnTp7VPXYu41lvIB21U5mFyo9
 MC2Qz6GZCapYxCFKlkWluUdnHQvrva0ywufYgwLyYlVB14sgCsU7A8mbAv99Za83vQj3ggZsHZY
 gVO/JDQzbAZvPy59NM6fFTMzt7JahqLJySEJk8eg/3LN1nXzom8sFkWPtHLEbWpChqA076TjDbB
 Ua8UokJQgqtU+Z8tty8ZphhKQyhcuEkCQ3k6gE/ed1k3YXGB0LXKazf0zhg+fl27jXqssi5wluy
 nr1n8wcWm2F/oWj70BP9yr4NQ4O2GjjF5JH2nkdNz7rw==
X-Forward-Email-ID: 69de1f7ca4032bc6de624254
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.7.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Tue, 14 Apr 2026 07:05:30 -0400
Message-Id: <DHSTUKN1JCDK.2FO2HZLZLXTOT@ubuntu.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <willy@infradead.org>,
 <djwong@kernel.org>, <adilger.kernel@dilger.ca>, <pedro.falcato@gmail.com>,
 <xiang@kernel.org>
Subject: Re: [PATCH v3 00/12] ftrfs: Fault-Tolerant Radiation-Robust
 Filesystem
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Pedro Falcato" <pfalcato@suse.de>, "Aurelien DESBRIERES"
 <aurelien@hackers.camp>
X-Mailer: aerc 0.21.0
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
 <bxgqldv2abuadh3gweymib2co6gfor7sgpbkouznj6jliyblfq@42xw4jviodeb>
In-Reply-To: <bxgqldv2abuadh3gweymib2co6gfor7sgpbkouznj6jliyblfq@42xw4jviodeb>

On Tue Apr 14, 2026 at 6:22 AM EDT, Pedro Falcato wrote:
> On Tue, Apr 14, 2026 at 02:07:13PM +0200, Aurelien DESBRIERES wrote:
>>=20
>> Based on: Fuchs, Langer, Trinitis - ARCS 2015, TU Munich / MOVE-II CubeS=
at.
>> Full text: https://www.cfuchs.net/chris/publication-list/ARCS2015/FTRFS.=
pdf
>>=20

>> AI tooling disclosure (Documentation/process/coding-assistants.rst):
>>   Assisted-by: Claude:claude-sonnet-4-6
>>   The submitter takes full responsibility for all code, has reviewed,
>>   tested, and debugged every patch.
>
> I was going to ask if you were on the world's strongest stimulant but, ye=
ah,
> this also makes sense.
>
> 3 versions in a day and no reply to review comments, no usecase, just vib=
es,
> AI ones at that. This latest batch even got the LLM to hallucinate my old
> email address.
>
> Naturally,
> Nacked-by: Pedro Falcato <pfalcato@suse.de>
>
> Please pick this up to every patch if you get to send more slop versions.

I'm not enthusiastic about vibe coding either, so I understand why you
wanted to NACK the series. But I feel obligated to say that you
can't claim there is "no usecase" when in the cover letter, a paper was
provided, and you even quoted it in the reply.

-Josh
