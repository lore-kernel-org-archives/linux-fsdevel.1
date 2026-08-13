Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA16442FC2;
	Thu, 13 Aug 2026 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623531; cv=none; b=HUX64TR4/n8IDh3dLKKaBls2KbUd6LaSddw85tOzP+dBJUgmdOxo7Xz1IHYmlN91E14JOwACnBT87ORLOjeP57MCQ0+OEO5k0D/XMBuJWobLD7AhppAnETPQAe/TjeoPeIIWCDCdq17/r81KHaj3CLJCUGiCSwx0Bb9oTyLtofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623531; c=relaxed/simple;
	bh=bx1auWMjtQ6lK77Ub+fPqi3tw5TQNFTmgBgtSoVMeRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KymYpLe8e84czeeITg8/sgs/NzXcV1eJgYi3de1G755yyeM3ELkwCyT52+8btN3Aq9dkHr3kslb1WUOaCdrkQqSLOzzy6mpfM0IxkuaTIcdz10AKdYq4t9AjgDfC7QoCR/bKXDeYqpxhFOj8FTXqKRloWRMwDtmhEmPfGNqGpDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYpj97qf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYpj97qf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A813C2BCF5;
	Thu, 13 Aug 2026 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786623530;
	bh=bx1auWMjtQ6lK77Ub+fPqi3tw5TQNFTmgBgtSoVMeRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LYpj97qfq8/4uunncx8KuPwgfOXjs0rw8uGLRmuA0F2V3UcGUpxgxD4AKwel7bz1d
	 DMtFMIyBQBIl+0Pfn+WkV3cwPWGM2uCVrKUlLLSmo4ROy1rXWkLyyh7ZJSLbjfTBm9
	 tJDRiGXg/UH0cBGqHA+r1tIk2ZYAke6omkHZ3TiwqukEjbXq0r0Ezp+YFnTKsH/kad
	 Xnilsn2tzu8BwXKEfEEdXE3PN1U3bEf31Hhgb4X8letqE2utERAgGDdLTPUW/fa7sX
	 ek38L6kKMGFSakv9HEHup+yqs8rJ5hy9OLhXJRHj7NwxCi1vnKpB0+MN8CzQy96WwW
	 e1sL7uNXBh+8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3D6C5DF69;
	Thu, 13 Aug 2026 12:18:50 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 13 Aug 2026 14:18:40 +0200
Subject: [PATCH 4/4] sysctl: Add 0013 to test partially updated vectors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-lklm-partial_ctlvec-v1-4-df9e51c13704@kernel.org>
References: <20260813-lklm-partial_ctlvec-v1-0-df9e51c13704@kernel.org>
In-Reply-To: <20260813-lklm-partial_ctlvec-v1-0-df9e51c13704@kernel.org>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-mm@kvack.org
Cc: Jianlin Shi <shijianlin11@foxmail.com>, akpm@linux-foundation.org, 
 vbabka@kernel.org, hannes@cmpxchg.org, surenb@google.com, mhocko@suse.com, 
 jackmanb@google.com, ziy@nvidia.com, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=bx1auWMjtQ6lK77Ub+fPqi3tw5TQNFTmgBgtSoVMeRE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGp9tigf0HZ/SOSipnWglbugNlaMER9isn8Ln
 HKjGsYXnp8SHIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqfbYoAAoJELqXzVK3
 lkFPa8gL+wVFctfUarU/BECGG+yem97ZpueVfSLV32B2PJJKmFL7c6BeArL3+nFK66TgrYUfEDI
 794BeoxGMD2zXrMWvkrt+ynKROFyKvwTTEiUXIy/2RLYaYWMfIHBlDpFhIlgxYOk+JRBGtZ9lCT
 jKEGmr8rUvShwgJ79bMF4GiJ2DyCL+FcGIA4ZZVAsYkaYocp3ryyn25z6J1zzanLyqnGBayYCW7
 4RmOuwTSD6qkmUE5kh9XezhlQhbYW639iHxhLnDmGS4tQ/nIiLrXIVTUdK5L7mVI8ikNwgz+Kz7
 /r4G32tJLbnV0q3aDiA4L7tBUUWlWO9/0vAtXw52FtmR5APUyDHPRntB9K9XN/IV5EZFxiSIhNe
 QhRZ/0aJjRBQf9lgKmyd2kTFs7VHY1gLNnJW0URRuJeCryne0K3vqm+zKpnwFs59ZLD8wPftoYZ
 MaG77XNioStWHAwaTevL7oRdTTv+C+DNryBbdYAxsSZcc0CC+0oew2BnXWGTWrnjwlzthSD8Vs4
 +k=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add coverage for partially updated sysctl vectors with test 0013. It
makes sure that the sysctl vector is unchanged when one of the elements
is not valid.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index b2d8bd9026a721e96c26be20069f7f87b06a5cf7..fdf3d2fb0a2ad23a525d3205577a06d7d97576b7 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -4,6 +4,7 @@
 
 # This performs a series tests against the proc sysctl interface.
 
+# shellcheck disable=SC2317
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
@@ -37,6 +38,7 @@ ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error:0"
 ALL_TESTS="$ALL_TESTS 0010:1:1:mnt/mnt_error:0"
 ALL_TESTS="$ALL_TESTS 0011:1:1:empty_add:0"
 ALL_TESTS="$ALL_TESTS 0012:1:1:u8_valid:0"
+ALL_TESTS="$ALL_TESTS 0013:1:1:int_0003:1"
 
 function allow_user_defaults()
 {
@@ -196,6 +198,18 @@ verify_diff_w()
 	return $?
 }
 
+# Verify that an erroneous ($2) update fails and does not change TARGET
+verify_no_partial_update()
+{
+	TEST_STR="$1"
+	echo -n "$TEST_STR" > "$TARGET"
+
+	if echo -n "$2" > "$TARGET" 2> /dev/null; then
+		return 1
+	fi
+	verify_diff_w "${TARGET}"
+}
+
 test_rc()
 {
 	if [[ $rc != 0 ]]; then
@@ -501,6 +515,40 @@ run_limit_digit_int_array()
 	test_rc
 }
 
+# You used an int array and one of the elements is not acceptable
+run_int_array_no_partial_update()
+{
+	echo -n "Testing invalid array element does not partially update ... "
+        # Expect failure because of 3rd element (abc).
+	if ! verify_no_partial_update "1 2 3 4" "10 20 abc 40"; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "OK"
+	fi
+	test_rc
+
+	echo -n "Testing out of range array element does not partially update ... "
+        # Expect failure because of 3rd element (greater than int)
+	if ! verify_no_partial_update "1 2 3 4" "10 20 $((INT_MAX + 1)) 40"; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "OK"
+	fi
+	test_rc
+
+	echo -n "Testing invalid first array element does not update ... "
+        # Expect failure of 1st element
+	if ! verify_no_partial_update "1 2 3 4" "abc 20 30 40"; then
+		echo "FAIL" >&2
+		rc=1
+	else
+		echo "OK"
+	fi
+	test_rc
+}
+
 # You are using an unsigned int
 run_limit_digit_uint()
 {
@@ -880,6 +928,14 @@ sysctl_test_0012()
 	return 0
 }
 
+sysctl_test_0013()
+{
+	TARGET="${SYSCTL}/$(get_test_target 0013)"
+	reset_vals
+
+	run_int_array_no_partial_update
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -900,6 +956,7 @@ list_tests()
 	echo "0010 x $(get_test_count 0010) - tests sysct mount point"
 	echo "0011 x $(get_test_count 0011) - tests empty directories"
 	echo "0012 x $(get_test_count 0012) - tests range check for u8 proc_handler"
+	echo "0013 x $(get_test_count 0013) - tests partially update vectors on error"
 }
 
 usage()

-- 
2.50.1


