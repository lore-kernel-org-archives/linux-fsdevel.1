Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB95531624;
	Wed, 23 Sep 2026 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178844; cv=none; b=f36jTjM4pWiwm6PJiqaxknHI60RfL+Xv1sbiFG/S5GBWP8lJkD+oAFAlM5a7yhQFwQYH+2v7bDik8sSqCrdtm9nKJC6GHNj2Ih3Hbnr1L+TafvScmuyqIyLn0j8YaDBDMym3GEniYF7Tk/7gR8vYMu8orxTvFUXaPKjcj6ieDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178844; c=relaxed/simple;
	bh=k7jzcVlXfL+ueAsxa1cZENIgayVIdQ5+9sdM2W3ajvw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MdVoQz5x/YU7qLnuxJR6PHWiKHcyWeOKe6Ax4wpInGhKHmPkJCAyU2tx9+uTnn8kYSBQfQ6OCfGEVRWmmNSePLZHomA6Nd+fQ/uIV8oQAFzhptrLNKRyN/C6MfCCsutmt+IegisfXTSx8Ilb6s3hJFvnApaPv0wy412tWLuIrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=htG+2zs3; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=eKvOEdIh; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="htG+2zs3";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="eKvOEdIh"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790178833; bh=BPF6cXxNRxHC5V0POq81PDg
	zHKxD2bonBRc3REH9gSs=; b=htG+2zs3xh0IUx3Jq2cwkoMNIXsgKajpVZLujvuuTmGbg25Y3C
	Ij2/YxzHthhKTJeaHKbY1UtWVJ5mRhWYGt1qiP5D3LAlnXKZYZKsMSHYtB/G0xhYGJYa6YDaBw/
	k5+XuOMzOA46M3ijueNtryfslCfFBN9D8f/47mTELPviJqpy2P4EJcOUtkJbZuAe4TthsiFv7Iz
	k29os3+vSNj6U4ll1XDqoNNBWUbDQfGo7SMez1bDldZuW5nA/9HXzvyrWdFT4fNDC0iqNtJHedJ
	nNcYB9FYUslLTqFIVHH4pxQMZGLx8djARsXrZQSE1XmflKaoZY4obM5fKNC4/wUWbbg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790178833; bh=BPF6cXxNRxHC5V0POq81PDg
	zHKxD2bonBRc3REH9gSs=; b=eKvOEdIhcFvIAiToLb3cgh4J+LAxi7K8MuNws3WyNid81LUc1/
	N4RzmmwbPcsHcqNEabDqZo5Pe1qo9pmWJaBA==;
Date: Wed, 23 Sep 2026 16:53:54 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Joel Granados <joel.granados@kernel.org>
CC: Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_selftests=3A_sysctl=3A_Che?=
 =?US-ASCII?Q?ck_the_sign_of_a_negative_jiffies_read?=
In-Reply-To: <20260923144940.3712965-3-zhanxusheng@xiaomi.com>
References: <20260923144940.3712965-1-zhanxusheng@xiaomi.com> <20260923144940.3712965-3-zhanxusheng@xiaomi.com>
Message-ID: <6DBE514E-E307-4E8E-999B-1B5592CE9AC5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 23 September 2026 15:49:37 BST, Zhan Xusheng <zhanxusheng1024@gmail.com>
wrote:
>proc_int_k2u_conv_kop() returns the sign through *negp and the magnitude
>through *u_ptr.  For a negative value it used to convert the
>sign-extended int and negate afterwards, so the magnitude came back as a
>wrapped 64-bit number.  Nothing noticed, because no test wrote a
>negative value to a jiffies sysctl.
>
>Write one to each of the three int converters and require the value to
>read back unchanged.  Each value is chosen to convert exactly at every
>CONFIG_HZ, so the test does not depend on it:
>
>	converter		write	jiffies stored	reads back
>	jiffies			-1	-HZ		-1
>	ms_jiffies		-1000	-HZ		-1000
>	userhz_jiffies		-100	-HZ		-100
>
>On a kernel without the fix, at CONFIG_HZ=250:
>
>  # int_jiffies: got '-18372957097414713411', want '-1'
>  # int_ms_jiffies: got '-18446744069414585320', want '-1000'
>  # int_userhz_jiffies: got '-18446742229035144346', want '-100'
>  not ok 1 test_int_jiffies_negative
>
>(paths shortened; the runner prints them under
>/proc/sys/debug/test_sysctl)
>
>Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
>---
> tools/testing/selftests/sysctl/sysctl.sh | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
>diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
>index ceb5cfa0cfd4..ad1ee0fccd7c 100755
>--- a/tools/testing/selftests/sysctl/sysctl.sh
>+++ b/tools/testing/selftests/sysctl/sysctl.sh
>@@ -328,6 +328,29 @@ test_int_plain()
> 	assert_int_range "$t" "$baseline" || RET=$KSFT_FAIL
> }
> 
>+# The jiffies converters report the sign separately from the magnitude, so a
>+# negative value must survive the round trip through the converter.  Each
>+# value below is chosen to convert exactly at every CONFIG_HZ.

I have a feeling this could be decreased, but I don't care.

Reviewed-by: Bradley Morgan <brads@mainlining.org>


Tested on PowerPC: 

Tested-by: Bradley Morgan <brads@mainlining.org> # POWER10

>+test_int_jiffies_negative()
>+{
>+	local t="${SYSCTL}/int_jiffies"
>+	local m="${SYSCTL}/int_ms_jiffies"
>+	local u="${SYSCTL}/int_userhz_jiffies"
>+
>+	[[ -f "$t" && -f "$m" && -f "$u" ]] || { RET=$KSFT_SKIP; return; }
>+
>+	printf '%s' "-1" > "$t"
>+	assert_content "$t" "-1" || RET=$KSFT_FAIL
>+	printf '%s' "-1000" > "$m"
>+	assert_content "$m" "-1000" || RET=$KSFT_FAIL
>+	printf '%s' "-100" > "$u"
>+	assert_content "$u" "-100" || RET=$KSFT_FAIL
>+
>+	# The positive path was never broken; keep it covered.
>+	printf '%s' "1" > "$t"
>+	assert_content "$t" "1" || RET=$KSFT_FAIL
>+}
>+
> test_uint_plain()
> {
> 	local t="${SYSCTL}/uint_0001"
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
