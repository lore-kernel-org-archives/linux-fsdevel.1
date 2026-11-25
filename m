Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599662;
	b=0meIrmEBc7O6sbRs40ix7FYH5oXNHO0ynbJfwxHesDd3hzcbJQB3YOmqALiunWFduLG+
	 jLQxoDCPxNDheNNh5t+g3iGuhJ2Xc5SwEl9t2gCy/1IKVkGx/OmPOSszOP3X8F/F+M7xz
	 3tT54CDp0wskq01Vt/COS8+U7D+lX7UzwjrsMI8jFiMmbn1IDBA/0KdLB9lTYKciP+2nL
	 BesrC3JO/pOw3Lrg0UsVj2bhZMqX4cka2cofUPPYr6BFeMmFhAL7g6wzOZ4PWmSeHfgB2
	 oxbyngdhrFbiE3jLfyzrJTmQ17/8pcOopSLK7ghgj2OzE2tYj6USefTyAqSPdrP0eVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599662;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=Go5NsoyuppAMWbSfZV52X8FSvYZuBcD031bthogNrOg=;
	b=GRKiT0/qKcstNL/nh6oPTSGWW7vy+a73NLrzAkYxlV2w5kvC6yU/KBBJwoMEr6kpl9Tk
	 cSG2lVsscnFXOfcDglLL1ldoVfQ2oXZFbfM/Xbslo7S4EiZcE5VpkI6vQXl/NSnAxo43u
	 4EbCpVaRqb4OYxLXNO/gkh2ioUymQ2mkZoMt+Rth+sL61XakmBFn0biYaPe25jPkjS+oQ
	 NfY1CE+Pkk0GCYaCQik/wXvR5HXlBQfk5fU0sZ2ZFUxm9sm3sIuyrYmbF/DD6lriSb7EL
	 nb2Y85CwMI+Ec5P3/bw1PJlc0fqpyS7fUn5yK4Y79zMnTIvkV2zG771yaNPs3QcXNEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5bwkYk2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A98606A321;
	Wed, 25 Nov 2026 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5bwkYk2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795599661;
	b=JPfLE9NDzOVjTdBjsc6tG7EdQjHYskFmWSnugC7CNHjjWQNHQRpssAHozxjpzrBQw2/b
	 ugmdCvnQSu9OpOkI74NKirUFYLxALo8g0ZJwoJ+edAEL2UDWsRS+jlcqEbYwCknnN2E3g
	 5k9hVRBOdQ49gjRqWlgJRZuEs3pikt4EfW8v3TD+xvwA0QJdNXcyLXP7qN9gk9kgs0WLS
	 EWVN+RAlP4+MZJvQSo/OnQK1osnjFq+qlykugDcflIGPAUa95KR2Wi9CEzuvUhNz0kW71
	 FGhREuJmGV6v8YT8o3ryaL9wImyLe3abDVo5/SQm92zjJE3Sdt6hum0RUqpSHT1UcWw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795599661;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=Go5NsoyuppAMWbSfZV52X8FSvYZuBcD031bthogNrOg=;
	b=Z97bCUH424gxUusAStbgqfyNjO+EPXHMCNYNRxU/HTjAq09VZOXOQ5+GQj/RrAHtyAnv
	 8imbo6s2+x2vCfG5hbDEWj30e4VFeMALBCC108QID2GKeCSmKSZyWBu0Lon+x8+eQmw6H
	 WLV7wN5HJXYhr+0xxzzFIOkHkThy+uvPP892o1kKmEaI4sEp04+UUnNDEdCeiBXOEhayx
	 /O3Eg0iuArcy7+FmZFC9q64bruM3Efc4vFQ9ZvCCt6vyxSC/g78oD5wf1Lcl1mLInCsp5
	 W8jdirKGJMAJI/H1/HAal4KXAJpVbaHt2QcGPD46XTU7yMdIPJ0YxgGil3I2kF6X96Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 33F321F000C4;
	Wed, 25 Nov 2026 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599661;
	bh=Go5NsoyuppAMWbSfZV52X8FSvYZuBcD031bthogNrOg=;
	h=From:Date:Subject:To:Cc;
	b=U5bwkYk29EPa66nNb/UD3FT0LSil5i2cyls9NfllzFytyL3TZosV1gJIsdfxZ26q5
	 bZJ5qeSwj5FtQkINKFFuEhQ24oMiu2muu7K3eCfKmxbuIeLep9wztwXmRxuIaaMlRx
	 71CoeAOi/nOs0g0NKci0qWe/kOq48Adt4B1hhNYR+ulxvIU2bXDtWHLW/FQHM3cmWg
	 GXyIQ/5hFGqboI3VfuppKNfTUNwf4lbERVjTyWICvLLs59kBn+C/dIwZ+yMs5velJR
	 ay3FKhZleNQ85E+gQKeL43km2b/TfDYdJY9XRfoIG+nL6/XAYheT1aoH4av5XwFXz6
	 Wlc6Yq1O1OCIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8CBC74CDF2;
	Wed, 25 Nov 2026 09:40:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 25 Nov 2026 10:40:51 +0100
Subject: [PATCH] sysctl: Test rounding behaviour in jiffy-ms transformation
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-lklm-jiffy_rounding-v1-1-ccf2ddf7bd3a@kernel.org>
X-B4-Tracking: v=1; b=H4sIACKtBmsC/x3MTQ5AMBBA4avIrDXRoSSuIiLolPFT0oYQcXeN5
 bd47wFPjslDGT3g6GTPmw2QcQT92NqBBOtgwARzKVGJZV5WMbExd+O2w2q2g+iyHAulO0WYQih
 3R4av/1rV7/sBEgGHdmUAAAA=
X-Change-ID: 20261125-lklm-jiffy_rounding-b46275db5e23
To: Kees Cook <kees@kernel.org>, Avi Weiss <thnkslprpt@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4128;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=RpJAkbVCo3PiYqOJBu0qHd458RHdZ3KqXhVVUhOgvQ4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGsGrSQ6ZjTQW/We47+1WsXkCJbRiidHpMEGS
 lr2z3gOOCCzTIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJrBq0kAAoJELqXzVK3
 lkFP+jYL/is73B+3x3Osc7NEipbbmNU9I5mXOvA209ipSqD1KBtjF7DGJMiIGvZ6d+KMOFqKXe5
 3mbamOYNw0Pud0yvxoMRYzV6hH0fw1q7a2Ld9ZSwd5Dc63kfTpfZCfcWlsb7nFi8TB2F8ktCatX
 70m5sHYTAU80Vg+AruwwQMG10TPQZSDUDdbZxTotXlot4V4Sd6bwcgEy15wG9HGD3UzLB9tOh4Z
 4EdrSVAMTlzajZootfipaLg3dhy93Y9QLQTebbZqddtkyyLUqwuUg1wmcCsl9SrZKILnFe5VN1D
 7OsaVtC+4GmrJCRF4zqch9jUl1HRdJA8McAWUWwxxSyCRQ03kqwy1+9QJ7U7+f40uNIHv75mqa0
 JUwVzht7FhMsQhbOhweq7aeQZ4VmwQQUGxFRLli4GdWhkV8d2VfX9b0/M0Ar2S4KSfwI/1KFLye
 HLjn+AfsKqWTo10e9we7E0+lH8SEh4V6HqKShfB4jPGIQI4TA07MdLX4OTbFtrcflrjGOd49bT7
 JA=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add two tests over int_ms_jiffies and ulong_ms_jiffies:

1. roundup_on_write writes 1 ms and requires the read to be at least 1.
   One millisecond is exact at HZ=1000 and rounds up to one jiffy below
   that, reading back as 10, 4 and 3 ms at HZ=100, 250 and 300.
2. stable_rewrite writes a random ms value, writes back what it reads,
   and requires the second read to match the first.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
These tests make sure that the fix that was recently merged [1], stays
fixed.

[1] https://lore.kernel.org/all/awH4Fh-XofdwwRqZ@hobbes
---
 lib/test_sysctl.c                        | 13 ++++++++-
 tools/testing/selftests/sysctl/sysctl.sh | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 65ce423461707170367a5df14999b571705251d0..40da8748c2ad283a8ac9fa9b859e8556e2dc3564 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -29,6 +29,7 @@
 
 static int i_zero;
 static int i_one_hundred = 100;
+static unsigned long ul_one = 1;
 static int match_int_ok = 1;
 
 enum {
@@ -52,6 +53,7 @@ struct test_sysctl_data {
 	int int_jiffies;
 	int int_ms_jiffies;
 	int int_userhz_jiffies;
+	ulong ulong_ms_jiffies;
 
 	unsigned int uint_0001;
 
@@ -72,10 +74,11 @@ static struct test_sysctl_data test_data = {
 
 	.boot_int = 0,
 
-	/* One second in each converter's unit; all three store HZ jiffies. */
+	/* One second in each converter's unit; all four store HZ jiffies. */
 	.int_jiffies = HZ,
 	.int_ms_jiffies = HZ,
 	.int_userhz_jiffies = HZ,
+	.ulong_ms_jiffies = HZ,
 
 	.uint_0001 = 314,
 
@@ -144,6 +147,14 @@ static const struct ctl_table test_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_userhz_jiffies,
 	},
+	{
+		.procname	= "ulong_ms_jiffies",
+		.data		= &test_data.ulong_ms_jiffies,
+		.maxlen		= sizeof(ulong),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
+		.extra1		= &ul_one,
+	},
 	{
 		.procname	= "uint_0001",
 		.data		= &test_data.uint_0001,
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index ad1ee0fccd7cefb066caf23d8aad42abfa046ba0..d24ac6c5a027248afbad4ee0331800fb00aa8978 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -351,6 +351,56 @@ test_int_jiffies_negative()
 	assert_content "$t" "1" || RET=$KSFT_FAIL
 }
 
+# Writing 1 ms reads back 10, 4, 3 and 1 ms at HZ=100, 250, 300 and 1000
+# respectively. Here we make sure that it is >= to 1.
+test_jiffies_conv_roundup_on_write()
+{
+	local m="${SYSCTL}/int_ms_jiffies"
+	local l="${SYSCTL}/ulong_ms_jiffies"
+	local f got
+
+	[[ -f "$m" && -f "$l" ]] || { RET=$KSFT_SKIP; return; }
+
+	for f in "$m" "$l"; do
+		if ! printf '%s' "1" > "$f" 2>/dev/null; then
+			ktap_print_msg "$f: write of 1 rejected"
+			RET=$KSFT_FAIL
+			continue
+		fi
+		got=$(cat "$f")
+		if [[ ! "$got" =~ ^[0-9]+$ ]] || (( got < 1 )); then
+			ktap_print_msg "$f: wrote 1, got '$got', want >= 1"
+			RET=$KSFT_FAIL
+		fi
+	done
+}
+
+# Check that writing back what was just read does not change it again.
+test_jiffies_conv_stable_rewrite()
+{
+	local m="${SYSCTL}/int_ms_jiffies"
+	local l="${SYSCTL}/ulong_ms_jiffies"
+	local orig=$RANDOM
+	local f first
+
+	[[ -f "$m" && -f "$l" ]] || { RET=$KSFT_SKIP; return; }
+
+	for f in "$m" "$l"; do
+		if ! printf '%s' "$orig" > "$f" 2>/dev/null; then
+			ktap_print_msg "$f: write of $orig rejected"
+			RET=$KSFT_FAIL
+			continue
+		fi
+		first=$(cat "$f")
+		if ! printf '%s' "$first" > "$f" 2>/dev/null; then
+			ktap_print_msg "$f: rewrite of '$first' rejected"
+			RET=$KSFT_FAIL
+			continue
+		fi
+		assert_content "$f" "$first" || RET=$KSFT_FAIL
+	done
+}
+
 test_uint_plain()
 {
 	local t="${SYSCTL}/uint_0001"

---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261125-lklm-jiffy_rounding-b46275db5e23

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>


