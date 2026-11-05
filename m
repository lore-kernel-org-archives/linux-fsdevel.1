Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892434;
	b=VcVd6sBJjekPqhmKCIPhRuNYEaD9DG+1bz3WubfOKKeONasDjqC4j96jwezMUww06Xye
	 j3E+Gj236BcIx5S1c/PHF18nxZXyXPa4Rh7FVO1atQwi6gWq6dR788KXp4Qy4HAVGVHa4
	 pAQB2X/gf2BV0kJvs8VeCQ8aPPkudLb6o4F3zNPw4g+l8UKm7Gi6TXA+YE1728JKyYB0L
	 ehRy/RcM8W632SYJk/Mtuv2N4EaZ1wpFJuMGe8RDVOdrhTQkrsx8XGusg3x+B1sFIzOB6
	 /Fsk8SHzTelwjp71NKwP3G86f9Dls37C2FNRBJNg3OT9xZl85s/VgawthvzHTEiotvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=2ansoqDUpGjBC5xJnIjBsV3PFVQvwHONv8Li7jiJVoU=;
	b=nyOA+hbHOopexpstqFDDU0f5Z75I5feI1axCpX0NGvbBxQTMbZb+vQMAwS8GOK4zECfI
	 HWv+NOS4cIwmj711qqJ9KIb5zCX/bNkc+rX90rcZKAZ2QB5AVC3z1uk5CXq+JvJCe0zHs
	 kjo35nBs2xsPzx2BUMVKnFa+npMOTBbFePSEDHX+zNbi3y/0My24JsAxvMd/z3YfoHskk
	 +m2ScWctik658UstlK2Wwo5Dylo7BnnB4ZFmWx+PKougeUy3AOPaa/raWIhjPHTxhMWTQ
	 JksQa6+FiM68t0FjYM/PwUXXGOx/Bhfj53md6+ZsjnyEzXdirYlCWC+t+OUyF28hZog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QfObJ7a0;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6F606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DA6F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QfObJ7a0
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f079a63b8so191076485a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892433; x=1794497233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ansoqDUpGjBC5xJnIjBsV3PFVQvwHONv8Li7jiJVoU=;
        b=QfObJ7a0G0zPB+wR2boS2HKagKATPMK0b3y64QcnoLsJWbdS2ikVBze5uU1RUjqobE
         mIwEAooueJ7AkdkqRBg7/jToz/SjyKKvMO32JqOsaGcXrpKr3mEtgApmOL25F9xuivpq
         KLgEvARdmfBUILJzCyLltfZV9Q20jgNkNUS+wKaamkkDQMNB3KcewZMWXW343RyQl/9M
         /+jp1JRRmVsFg+YgffcDtgwF+hVECWB2aYzM9cCjglnScyloWIoX1sBj14hAezxt0s8d
         gywOHtqJfALJmbJlsQWAi0M6nU1a1gbNB3XOM/IH0QOpDT1lBFI3NYNHRWZKK3w6leAA
         DnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892433; x=1794497233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ansoqDUpGjBC5xJnIjBsV3PFVQvwHONv8Li7jiJVoU=;
        b=U18TXhhs0GousdMfuknvuUNd5yEXYwXz3JTyVl7/V0Bl4kQE9Py6MDFBM8FMquQh2G
         IfM2ZY+YJ8ZvHOWD4EZ5eJQgPavoi6HC63xFHVGfT4IlZ+2LWMVQNpMCuX6PE5R1i29+
         gEWVcbtkYKtXnSMbrf62QpMGwZnPQcdA78OJj30DdA0DCW3uEhZJfUo9W6r8sM+xaO72
         L0Su9hwAPuLKmgpr+ADW81rr715yZPCyc5oLI93OaZh8FmQLc/GWCDXc3J9Mth76PDe0
         IKFFcI4cnZetiiAk9q463K8ctyZpwxJI/Zfy55n/DDDLJG/x6zkNpvTeo92qFJAh1jKu
         m2vg==
X-Gm-Message-State: APuU4Z+RdUaX2tKNHQbwTiFZ0sGna4YcHfYehV1eanR9QHIZDXRvnm8L
	uXjxP8eW2V7dv4B9vZpSDvPwDh1iFfaf62OlvgabDkohP+URkfNWZAptUexMFo0m1ME=
X-Gm-Gg: AYBFou27L8ap3jA9PKtImf0/gxkq6Nk4tK0l5xm5CC5Cjne9a6rVTcJUmPZ3RiQ20jl
	xdKyCpZJGvdGETPW6LVSD9c1eB8ykCP5Lrbo0CtZ08jWo/cxtVfOGfrwJ3KOb9M3/Ajma+MrIIH
	HrWMaQs143yMMo+xkQn4OBT/EmB7kcEYE0g5L2AYbwE4qFucp96LwXM7MDVkVdqJDge5Y7ZyRGk
	K3ONaY33LNPIwaJvk8sq+F2vp4YAWBqoEt3sZjROXyMTlrlTNDuKtugZyf8IrsK9yvJLNIu5bqJ
	4KgjnHdIQTKli1B/83jcNZPYUTuK6lLhYLGlroVBGrAbChb88fM+uM0cub0vkbHXlAvabKWvqCY
	EcZmWfl2/XenqDsj3rdvhamJKhVKWLSBp2VYh/HIPEmqdcCl3k9PcxY7bLPGoS/TiNmdTvjK3us
	UB03MqzV/d2hU7dYK4OnbXBlBLsHENKPa3G1aDaVapUF/N+hZsCLqM1xgieDkuFszsoHrEPGAB7
	fCBxvSrwz3YWOcVXZ0v/PeLGzaEll1+YhU/akFCQl9AVGs4AVTwO8wwf0DAnYn8uumJj6xWojrx
	5vw3kFgF0x9ETK0gRlHAjjJtmZiiYSv9s/cA5vSbayK+2Q==
X-Received: by 2002:a05:620a:3183:b0:93f:26e7:844 with SMTP id af79cd13be357-944217942dfmr3186410985a.55.1793892432949;
        Thu, 05 Nov 2026 07:27:12 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d479a81asm484462885a.14.2026.11.05.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:27:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:05 +0000
Subject: [PATCH RFC v3 73/90] cells: add the "net" slot
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
Message-Id: <20261105-b4-cells-v3-73-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=3462;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ey37mzHZblXCf7M1GK29NesPtmaon7wfyZ1vlYLZpTw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHmZlb6aDHIeF8hCBPjo3yYotvS5ZOLdyibpa6kLs+3Vgtq5xlhcWPqk1V9Uj0Wa+MnfUiqVJah
 JdCggQBe2Zws=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The network of a cell is set up from the outside and handed to the cell,
like its mount tree.

A capability over a network namespace has to be held in the user namespace
that owns it, and that is never the user namespace of the cell. So no task
of the cell can configure the network, not even its root user. Compare
unshare(CLONE_NEWUSER | CLONE_NEWNET), which gives any caller
CAP_NET_ADMIN over a network stack, and with it access to a large amount
of code that was written for root. A cell does not get that.

There are two ways to fill the slot:

  - CELL_SET_FD with the key "net" gives the cell an existing network
    namespace, set up however the builder wants. It requires CAP_SYS_ADMIN
    over the user namespace that owns the network namespace, as for the
    "root" slot.
  - CELL_SET_STRING with the value "new" creates a network namespace for
    the cell. It is owned by the user namespace that the cell was created
    in, so the builder can set it up. Until then it only contains a
    loopback device that is down.

For now a cell whose slot is left empty also gets such a new namespace.
The next patch changes that.

A later patch adds a slot that lets the cell make selected changes to its
network.

A network namespace that is shared between cells can carry identities from
one to the other. Only unix sockets know about cells. The builder has to
take that into account.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cell/slots.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/cell/slots.c b/kernel/cell/slots.c
index a96d2f262aa1..75855f2ee020 100644
--- a/kernel/cell/slots.c
+++ b/kernel/cell/slots.c
@@ -93,6 +93,36 @@ static int cell_make_net(struct cell *cell)
 	return 0;
 }
 
+/* "new": one that is made for the cell, for whoever builds the cell to set up. */
+static int cell_set_net_string(struct cell *cell, const char *val)
+{
+	if (strcmp(val, "new"))
+		return -EINVAL;
+	if (cell->net)
+		return -EBUSY;
+	return cell_make_net(cell);
+}
+
+/*
+ * A network namespace to share. A file descriptor on one is no authority over
+ * it, so it takes CAP_SYS_ADMIN over its owner. That is half of what setns()
+ * asks for. The other half is about the namespaces of the caller, which do not
+ * change here. It goes on belonging to whoever it belongs to.
+ */
+static int cell_set_net(struct cell *cell, struct file *file)
+{
+	struct ns_common *ns = cell_ns_from_file(file, CLONE_NEWNET);
+
+	if (IS_ERR(ns))
+		return PTR_ERR(ns);
+	if (cell->net)
+		return -EBUSY;
+	if (!ns_capable(to_net_ns(ns)->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+	cell->net = get_net(to_net_ns(ns));
+	return 0;
+}
+
 static int cell_set_ids_binary(struct cell *cell, const void __user *uvalue,
 			       size_t len)
 {
@@ -131,6 +161,8 @@ static int cell_set_string(struct cell *cell, const char *key, const char *val)
 {
 	if (!strcmp(key, "hostname"))
 		return cell_set_hostname(cell, val);
+	if (!strcmp(key, "net"))
+		return cell_set_net_string(cell, val);
 	return -EINVAL;
 }
 
@@ -150,6 +182,8 @@ static int cell_set_fd(struct cell *cell, const char *key, struct file *file)
 		return cell_set_budget(cell, file);
 	if (!strcmp(key, "root"))
 		return cell_set_root(cell, file);
+	if (!strcmp(key, "net"))
+		return cell_set_net(cell, file);
 	return -EINVAL;
 }
 

-- 
2.55.0

