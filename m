Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693677;
	b=Vl2JARYJWo7iHZDmGc1vKqiUep1E/hebBeSCiQysmg90PjYY//C3uVElU1oD/msF0Svb
	 HDmjJTMp5Xgli3OdpG9AOZKW48ZiebXr70rNv0pRjDxpyhYqxqr5FimAALabHEIGws3Gl
	 7SiwXQHXJLhzu4F77aHzQ2HDWN7AQV7sgQwp3VS/Edb8xvLaFPQ0DRpzBYa5bni4a0Pkm
	 yxjZXda0M0KRsnRuKtjgWlgiotN3TOnEJaa3K8mO7xqku/q91BnhmpKTyfZBRdbIIFuGg
	 1wgNkn0fb5Hxg1U1oNTEQBbbAKPonE2LHr/uV67nhYIiPl/XH/qL9drNqf4JB6XmZ7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693677;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=UffTJQ4pVfY0kHZkIsYzlAQzKQyZDyqriHCb2vsf00I=;
	b=XoZeKtvkDgyx2D5NwdZI7WQgOuq0xUuwc+/yL5sXbx/wgfbMEj7vLxrK5oCjdA26WBZB
	 vVqVIRhjklc5oVJQZEqglVcByCSkvdgYo9iqqsxYY8V0KbIt9o1sIdrnWwy2yvt3+nlTR
	 zabwqnXhq3OWJdhFwZH6i5urFGIv2nxfR2gOBjLs76c6a4kRi0BKWxF9ATe1D8G3hfF+U
	 p7DFC0aiOTOgxNXRGz8bw/e+JslnsaOcDgKGpCbNxivonI/M3qBqqnetpPTbarj65QMwI
	 UDjabQoBEkOvbZCU413bZezr8sLe9HbXo5zGDNExzS+uGe9rkj7Wt9bsitwwPG+ffnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PA3XooGe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF9606A31C;
	Thu, 26 Nov 2026 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PA3XooGe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795693676;
	b=AsbelUTebOk6jd8HRT/6rfjcfcXhebZcXzC6TipW5dQobWDYZ4PO6Spm8+BeBJBpd7Te
	 64TzXDdU0dAb3zIivmY/x+RtA1PvNUEibZjalL3dBoyq9IUGaUum0kETc9Qy8FuNao91F
	 MPRziFTdUAWW5bS8fbF7feW3AiMAaq9oilJXvtahj/+CwytY3N3XMX9hoMJCXZDGi/F45
	 yMAOLuL+/vEkROckeJU1o/1XNN3Q7O5W0Yg5ph/DJesF5yIX26HlkeK/O4zMIhGDvg0+Q
	 CrAUEZtc3xmX2TB8s+1FCZLbhPWASSDq/NF9XrXPgva3e4/VbXlJEQAWs2sBvOZqoRQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795693676;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=UffTJQ4pVfY0kHZkIsYzlAQzKQyZDyqriHCb2vsf00I=;
	b=A6C1HyTBhsbCDZkIzrhvMd+ncFEg6OanS10lFBzzoszbFRex3rdqwemqQA6n2JOnrIan
	 WqhvdGEGCwQWJqJqLenK2Knn95FJcNqVVYUJtC8G/n16+77zfy8BkB5AIOEen0lRr6pqw
	 mqIchnYuLenqVLZ1nrOAQxyKwvef6ZZXsDaOOVJ8GPE9QwKyzcrRxxl4StfyvE1IeOzPB
	 HAVDq1GPBKxhSfNqW7RWA7/jrT3tsakY07db7br5xFOZFx+NRZB0zfTOO2r22IlprMBwh
	 OU3Mow0yp0HHu+zJO80yh9VNibFTReWarZ7kPbpc8uX2EeDRa5ajmx+9ziJxeXb5Gsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 447151F000C6;
	Thu, 26 Nov 2026 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693676;
	bh=UffTJQ4pVfY0kHZkIsYzlAQzKQyZDyqriHCb2vsf00I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PA3XooGepInrNw+/4KDUMJGCakfWpHVwQAj/VT1ciJaOQSqKPVKcB22AaRbYV+zFR
	 XBH17mQEH7fFETaIn7aifJAh/oL2bLqYA+A7hU15lUzPF94cTACGqqf6CN3/crrFB8
	 ELr/Yf1H6y4caq8MI72PEyy/FYd5UVDLw5p3kUUcQwirjnC30MO/KvCNlSYX/pOJCA
	 ai1Y0aLVvBES33Ws4IEasICwewYZURU1QSSE0ntXKYrTnnaQI3A+hZUoyb+iLlTOPw
	 kOpG165jMDY4DA64m3Gmysdher7Tous+/UavPcSEvP1Y+kFZC8vKjdyTrVdFLTt+K1
	 B6GXI2e/yT9og==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BDDA54D47D;
	Thu, 26 Nov 2026 11:47:52 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 26 Nov 2026 12:47:41 +0100
Subject: [PATCH RFC 1/9] sysctl: Add struct ctl_table_tmpl as a distinct
 template type
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
Message-Id: <20261126-lklm-sysctl-ctx-flatarray-v1-1-d7fc9cc9b03e@kernel.org>
References: <20261126-lklm-sysctl-ctx-flatarray-v1-0-d7fc9cc9b03e@kernel.org>
In-Reply-To: <20261126-lklm-sysctl-ctx-flatarray-v1-0-d7fc9cc9b03e@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, Wen Yang <wen.yang@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=v6PmrMVI1lqvodBG+IMqrzbyXbDvVWx1Hl4IK0D+2nc=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGsIHGKO/2REFmXrRGqL8fZBwAqa21X/ylmBF
 ZdZBdkv08eRiokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJrCBxiAAoJELqXzVK3
 lkFPnEoL+wcw0+nJhpUcbftz6p0mnR8zBhZSfpXQu1SxDQBSaU5bV4mo7EXSfNbWD7HGNyS8WoG
 fHLImOARrNYoDr6zS1fgadhLfKoH5vQlmu0l3TweZLiLU6h1/lrPitRxLLkT1Nz70Oz0vb9P4C1
 Y8yviFC57jOIzbPHzgnHcmHKy4SGzY613y5wcnJCllNNt5eiAZ1bSDTXHxiYgDAcFakOV9ZkMPb
 IzyvzJnQhRiySvmarVtY3eWQqFK71IacIgVdBj8gOba/LurjuEFzlmP9fTC1L3w9FAC7bAZ2zZY
 ipAus0EpjUeVmUN29eyrjSo3jtzrIiNKr5L3ptiaOnORJJXyLPdNId2bCnPu56GCP2Eu2etu0Fe
 Gm1w66cfl5MDLrRYFh1G0fiWqbBhzrMtqg3X5XWCMUjPnTUEjvlvAU0Dw56ANqnLNOFFIDnIuIb
 ZBWPntRxqeNE4HgXaRcwGJ+CxR0/ByuWoVYH2IC/MBEnJa4q1HLVT3Sp45Yv1Vk+2TybiK9Up95
 /A=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Introduce a new ctl_table template type identical to ctl_table for when
the table caries several different versions/values of the same path
(think namespaces).

This is a prep commit introducing the struct, no functional change
expected. Sysctl core expects these two to be identical except for the
name; ensure this with a build assert.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e5d7226ab6f5af34a33829883ad5d1b405e19c86..4faa3bc189e7afbc270f4ba14b04b32a3f2d1413 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -22,6 +22,7 @@
 #ifndef _LINUX_SYSCTL_H
 #define _LINUX_SYSCTL_H
 
+#include <linux/build_bug.h>
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
@@ -230,6 +231,15 @@ struct ctl_table {
 	void *extra2;
 } __randomize_layout;
 
+/* Template version of struct ctl_table. Used for registering ctl_table templates */
+struct ctl_table_tmpl {
+	struct ctl_table t;
+};
+
+static_assert(sizeof(struct ctl_table_tmpl) == sizeof(struct ctl_table));
+static_assert(__alignof__(struct ctl_table_tmpl) == __alignof__(struct ctl_table));
+static_assert(offsetof(struct ctl_table_tmpl, t) == 0);
+
 struct ctl_node {
 	struct rb_node node;
 	struct ctl_table_header *header;

-- 
2.50.1


