Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5780390229;
	Fri, 25 Sep 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348645; cv=none; b=F00AitawtWfNeEDAlhKHpssRSea3CPpxC8yLxAhdyWK5dT7X1N9dL47oPMLmL931X67zyswwDhlJVfhcl7fLZBQumtZ3RL9A/OS7x6aSqrtyNxbqRPajHXuHZtsx5XYKpEieTkI2PtOwVbEmxpnadfiWjMQnF63xvrzrCDhPle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348645; c=relaxed/simple;
	bh=A2ca8hhJ3c3TUBOVJLC0jSWH0/+c5/DntHE0VkHi394=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PzuJcxT5rkrHxC5pebDUf8qoeMyZiVp/vyAua6mjQnrk6jpCyYfwEjlYVdnixngfLvfqkz8ujKJ8PHKjKJbS2Q1qgP0UUUykFG2o1/94bQ7HL2c+kBp2FvCtPahxYCSw3MhBsj4hrJ245YZLP4tUpCFce/8pTNA4KlCbDmlK/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=UypUqYzo; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=1zOOcG6l; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="UypUqYzo";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="1zOOcG6l"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790348623; bh=28hak4JVg+NtSoE4hvMIcoT
	U7Adk0ZOltVaduHjHhZo=; b=UypUqYzo3zwd89hp8SgCcTiIEzaNkkAlxdYF/OueYDOcFrTDX5
	rQ6izSlmP3TaaUoR5U/KcV8Psnw3ZDPB+tBJwvXDoe9f76adOhfeWW9p0M4EGGa0h2SYnhwEpLO
	CQKR1eDNnILXy8tPuBpBPIHbwJRxWohZSEuYiUgBhGyhLfGm4io0HUt4jWjlCi+kr3d2sivaoOG
	A+ZVEAeVSBHV1FYUaJym3zx5M2xvq9rnMaHQXtHcdG0B7qqOR9xMfBPqMSWVwHDp+8AJUxa2Jd8
	oWj16H2ygAGXi7ZxVK7qv9lCsb0X9nzE5l9bjMMee7xTjccjrhAjkV+1+pG5XnEgmzA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790348623; bh=28hak4JVg+NtSoE4hvMIcoT
	U7Adk0ZOltVaduHjHhZo=; b=1zOOcG6lB3PyDqbBNyPFF3ezZwPfevd0Dn7awim7P1xarX4Lg9
	yPlkQSyZuLBJT2//fJWOQgMmFaUgQmlsq/Bg==;
Date: Fri, 25 Sep 2026 16:03:44 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Joel Granados <joel.granados@kernel.org>
CC: Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_selftests=3A_sysctl=3A_Che?=
 =?US-ASCII?Q?ck_the_sign_of_a_negative_jiffies_read?=
In-Reply-To: <4wuqtjbpekdnpf6gn7pjc32bed2ln44unp2dd2zatiju4zeq5e@efqhttn3pfyc>
References: <20260923144940.3712965-1-zhanxusheng@xiaomi.com> <20260923144940.3712965-3-zhanxusheng@xiaomi.com> <6DBE514E-E307-4E8E-999B-1B5592CE9AC5@mainlining.org> <4wuqtjbpekdnpf6gn7pjc32bed2ln44unp2dd2zatiju4zeq5e@efqhttn3pfyc>
Message-ID: <E0D7623B-F209-42AA-BED8-39755CE4BCF5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 25 September 2026 12:45:27 BST, Joel Granados <joel.granados@kernel.org>
wrote:
>On Wed, Sep 23, 2026 at 04:53:54PM +0100, Bradley Morgan wrote:
>> On 23 September 2026 15:49:37 BST, Zhan Xusheng
><zhanxusheng1024@gmail.com>
>> wrote:
>> >proc_int_k2u_conv_kop() returns the sign through *negp and the
>magnitude
>> >through *u_ptr.  For a negative value it used to convert the
>> >sign-extended int and negate afterwards, so the magnitude came back as
>a
>> >wrapped 64-bit number.  Nothing noticed, because no test wrote a
>> >negative value to a jiffies sysctl.
>> >
>> >Write one to each of the three int converters and require the value to
>> >read back unchanged.  Each value is chosen to convert exactly at every
>> >CONFIG_HZ, so the test does not depend on it:
>> >
>> >	converter		write	jiffies stored	reads back
>> >	jiffies			-1	-HZ		-1
>> >	ms_jiffies		-1000	-HZ		-1000
>> >	userhz_jiffies		-100	-HZ		-100
>> >
>> >On a kernel without the fix, at CONFIG_HZ=250:
>> >
>> >  # int_jiffies: got '-18372957097414713411', want '-1'
>> >  # int_ms_jiffies: got '-18446744069414585320', want '-1000'
>> >  # int_userhz_jiffies: got '-18446742229035144346', want '-100'
>> >  not ok 1 test_int_jiffies_negative
>> >
>> >(paths shortened; the runner prints them under
>> >/proc/sys/debug/test_sysctl)
>> >
>> >Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
>> >---
>> > tools/testing/selftests/sysctl/sysctl.sh | 23 +++++++++++++++++++++++
>> > 1 file changed, 23 insertions(+)
>> >
>> >diff --git a/tools/testing/selftests/sysctl/sysctl.sh
>b/tools/testing/selftests/sysctl/sysctl.sh
>> >index ceb5cfa0cfd4..ad1ee0fccd7c 100755
>> >--- a/tools/testing/selftests/sysctl/sysctl.sh
>> >+++ b/tools/testing/selftests/sysctl/sysctl.sh
>> >@@ -328,6 +328,29 @@ test_int_plain()
>> > 	assert_int_range "$t" "$baseline" || RET=$KSFT_FAIL
>> > }
>> > 
>> >+# The jiffies converters report the sign separately from the
>magnitude, so a
>> >+# negative value must survive the round trip through the converter. 
>Each
>> >+# value below is chosen to convert exactly at every CONFIG_HZ.
>> 
>> I have a feeling this could be decreased, but I don't care.
>
>If you don't care, don't comment.
>> 

its because I think it could, but it isn't a complete patch breaker.

>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>> 
>> 
>> Tested on PowerPC: 
>> 
>> Tested-by: Bradley Morgan <brads@mainlining.org> # POWER10
>
>Please don't suffix anything after the tag as b4 picks it up.
>
>Best
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
