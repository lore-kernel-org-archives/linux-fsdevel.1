Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1E4570C2;
	Fri, 14 Aug 2026 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704085; cv=none; b=kAlve37aen2jcjgZzKieJQHqg++SCZkNPopIqeGPwYPmlEm1PlQqmbeMx7J2x/kLkxptEVfTE3eIdJSd28/wZvcMx2akiEEPjDbhEQQNti0xzMdT7FcRNChQXEbhNVje2LFbMEVxuJ9JGtjCHT4xN95KL5NuVD+rHeOxULgLgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704085; c=relaxed/simple;
	bh=YHI3VBORAsd9SqfY5aar0OvGzZqdtGpSqI6smTfSLXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d5x2xdu4mI3pcnUzM6Cn9G5owQ/OqBsrn74G50DM5ssvOhHhIAFwkU2Wk5marLmisgp8kZFu6/riptcZNj6jqgkxaHfAOi1amlhR/jYz0ks7aZJZwUh5zyG7GgtaR/yNvcXGgXApj/A86kNwCeYNima/VPPftpRM906bu5LrJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvZR6r2s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvZR6r2s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEE67C2BD00;
	Fri, 14 Aug 2026 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786704083;
	bh=YHI3VBORAsd9SqfY5aar0OvGzZqdtGpSqI6smTfSLXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gvZR6r2sAk+83hGeBZm5n2MK5vP+Q1JS+FYof1FPUtkEr8K1hckh+rQfCr+iMnC0/
	 7OGsT0A727GWC48yIcVuyfkDCvsjvwhaUPykcg4Qozpy6ktL/k4i2ddt6T3ldiCSw9
	 xPc3tY2fdCn9UqUOuXAPIOnJ5ZZD5XsWsEdTFG+7bk027mB1uu+/HqmR+YdzbfLfp/
	 K+jmx6X/yCeCtwwoAWXVcD4oqC/4ey9tCvYTm6cXAM3TBAqo8suNZpTuTPJ5vq/UfU
	 aQ2wh3gix4NxPEg1Kchd/gu2uhXS9hoO4vCNuzZnvHNiR24secduk/o9oNxB5xWfv4
	 FFxvEb4AgApEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5602C5DF67;
	Fri, 14 Aug 2026 10:41:23 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 14 Aug 2026 12:41:15 +0200
Subject: [PATCH v2 4/4] sysctl: Add 0013 to test partially updated vectors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-lklm-partial_ctlvec-v2-4-9df50d26e477@kernel.org>
References: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org>
In-Reply-To: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Jianlin Shi <shijianlin11@foxmail.com>, akpm@linux-foundation.org, 
 vbabka@kernel.org, hannes@cmpxchg.org, surenb@google.com, mhocko@suse.com, 
 jackmanb@google.com, ziy@nvidia.com, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mm@kvack.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3356;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=YHI3VBORAsd9SqfY5aar0OvGzZqdtGpSqI6smTfSLXY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGp+8NEZx7DhoWX+VVmoWYcszozrHrTSVyWWi
 NensKkTznzrsIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqfvDRAAoJELqXzVK3
 lkFP5nkL+gOLrefeg7tdLifVFAOWe9dtn+spU/1WLrN/o+x2sYe9+IVhJQKAT8S1ikOZr0D1eNa
 ASVm4Sz9LPGPHEAUuF9EtwF6qqrWg/3ZNGYZ+X05idINQ3jROzIMrcxRglhxOCE+8MYZ5lwAume
 VeSpQStAWQcO4TqMHUs9CiJrvxHSS4AEnddKvwFH+AhN+5nahkgwpXHAvtvN4CXFpYpZlCeUE/Y
 gCRVJQ3ikhBtkDn5YOhXbPoiKRtqTnPiSEfG87ibN8hILuti4JAeuNrY9pzJuH4D3Clicp3hxsg
 LV3YL3CXAYi3oNKW9vq4SI+YGEoSOQUMEwfAI9fEDSI9XNEgNc3ENL7IfDDiWayX9crn7X/HD8C
 ILHDSwaMPOP/+pwf8GUE73GS6ow2R/Z0geldHXgpe/IHZopgMiwlcL3VzouyJm67V1bq7dSwLFf
 +d6DLLGQUDuYHBQk8Ds/ZZjVtQjNL4h8nRc26WCMiblkgBQzLFSAwZHjwBkT7ysaMoM8kGxwi95
 08=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add coverage for partially updated sysctl vectors with test 0013. It
makes sure that the sysctl vector is unchanged when one of the elements
is not valid.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index b2d8bd9026a721e96c26be20069f7f87b06a5cf7..dc8674455284612dfe898944b886d856fb8ab3fe 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -4,6 +4,7 @@
 
 # This performs a series tests against the proc sysctl interface.
 
+# shellcheck disable=SC2317
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
@@ -12,6 +13,9 @@ TEST_DRIVER="test_${TEST_NAME}"
 TEST_DIR=$(dirname $0)
 TEST_FILE=$(mktemp)
 
+# initialize for individual tests
+rc=0
+
 # This represents
 #
 # TEST_ID:TEST_COUNT:ENABLED:TARGET:SKIP_NO_TARGET
@@ -37,6 +41,7 @@ ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error:0"
 ALL_TESTS="$ALL_TESTS 0010:1:1:mnt/mnt_error:0"
 ALL_TESTS="$ALL_TESTS 0011:1:1:empty_add:0"
 ALL_TESTS="$ALL_TESTS 0012:1:1:u8_valid:0"
+ALL_TESTS="$ALL_TESTS 0013:1:1:int_0003:1"
 
 function allow_user_defaults()
 {
@@ -196,6 +201,18 @@ verify_diff_w()
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
@@ -501,6 +518,40 @@ run_limit_digit_int_array()
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
@@ -880,6 +931,14 @@ sysctl_test_0012()
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
@@ -900,6 +959,7 @@ list_tests()
 	echo "0010 x $(get_test_count 0010) - tests sysct mount point"
 	echo "0011 x $(get_test_count 0011) - tests empty directories"
 	echo "0012 x $(get_test_count 0012) - tests range check for u8 proc_handler"
+	echo "0013 x $(get_test_count 0013) - tests partially update vectors on error"
 }
 
 usage()

-- 
2.50.1


