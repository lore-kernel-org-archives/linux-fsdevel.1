Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891403;
	b=L/iyyL7OB5TQmcc6IaK2CQTBgv1QF1Tja74SM6zVpHJb2N28MMVR90wDLPswZWMuaC6P
	 96kR5BA4P9+DuPSvnSvIoL7RmTpPFHmUzgNAlwEQalyTqM0CVn1odEnfwExYMBfC3EgiH
	 MuVqGTnjsvmpW4HfT6jn21W27z+QFA0G4kivTTzxWil9FEuI8MbcUaf8vLWb4B2lZSY5Y
	 RblBZOu0fkZbGDErQ/9L6A3FB5Dph9CdVw1YiA1QLwBJzqZ4sAEtvfxq+1INTvQys2M74
	 cGRFvda8LgZ+3KtL5gFX/u5ESQO1qRXlC6ZbGkJyGunGeEYCLSc/+jl/mhrEQXfddGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SONjZYRv1ckGFmSfkMm2m07etEBBhKJvU29wRk5CmFA=;
	b=o3ieGVofYDMJJuHGY+MQgWn2EoBzMtZnCbGM/QtTRPiZ9Hs566xxcTKFgE/6xPpi75RR
	 jOl0AsNObayFpxqfSMuKjkpAy9oNXjHvA9YiquuOGfG6JWagi0ZKDCRW4RzOppwT4SjV0
	 r4xOOwxWMz4CoS7dZUPOu+rBOomWBJXSU2RmZeX5/zz2j1hiCMLAV9LCcxuxxGVwRfNQs
	 FQtRIdiBotFCtOVncT+qHVYpnzrivllh/+/KZ1msZqrzJNMRz57iYlE0LYFrXhjj3e4VZ
	 pQnzqjJiqNDNBafp3jcweo3biAylgi2mkIOTNfFMi3OEkeJlMg9qjpHEX9JLmjErvzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=JkRbPk8S;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AFF606A32D
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9AFF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=JkRbPk8S
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ac9d666d4eso24240747b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891402; x=1794496202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SONjZYRv1ckGFmSfkMm2m07etEBBhKJvU29wRk5CmFA=;
        b=JkRbPk8SBtJBdOW5WjF/lfB8av9sgiHpDNhZRpiMMQWPkJgLKnFwPVWWcF1C92cqI+
         Mt9vyz4NQTGDOP4SYxZF07TWnNVc37Z0L5m5QKtQ4NSkC//gMfel4SBmnNeFfswc60JU
         JbHs19dOicuhjI9aJLJewS8znzSco04ASSWtujHq2WkzZ4lodEzEfuYZi0mHOWbvC5k+
         AGw7Lqv4WAS7yN6Y8hrwCxsu0fFDo4Syoot4J+lCenAdZ+BQnp7g7GzBzjI5k3luLVJo
         6ELIE4Mf+qo1ADh+tJxrv6RiyPTmBJN8bJhbh9rREzGLOVqSOS9lCXp/Xnu1oZ+K/7qH
         P8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891402; x=1794496202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SONjZYRv1ckGFmSfkMm2m07etEBBhKJvU29wRk5CmFA=;
        b=d0lO30TeYTtzCr8d84XI56SdggwFdubHNcq6JdX77ZVleNyKRyZ8GqlnuBi3GDPLRk
         5/OdDEB74qQPllkOS98646ZYUtTpB1GLEc07jbcM0ht1QPiw3yH9PXC3j4tFgnbTNRqy
         eS+Cw3V+0FRHRYw4wKsAqOReb8iPdtwvn9B4ZzvUaYEVpbvXw+CX/ROLBTSVRLwSQouW
         1leQoNGz36MIr78Z+RpR16V5VUfysHHmdopiy7pCFy22+JUNd2H9Leli7DPxF25TdL+u
         h1u9ofu1fw+eup1GlLo7fZm3Z/qOZlmivAvUfeBiUuWkplOy1JIdFHqH8erYG3mpuIp6
         12IQ==
X-Gm-Message-State: APuU4Z9b5D9xSJqw9xKeRJ7u+JlUbt0SMmyHHM7mjDSVl6SJLpUPV8Y+
	PkWalsF4Q4Gd6t+R3nwx72uuAawyE/+cJObFtPTMDTmrCT9ltF2cR/4v9tbOHwRV/h8=
X-Gm-Gg: AYBFou3/fZFbL/iT+b4GjtpzuL+WTTnstmQZbkGIYrDu+wyFcfSM6Sy95yVaaKsQuPu
	PpYaX+u5f/lJEzqzuEAszhMOAV+wxM6QD0iUDNSnAmyNyENjcAgAkYj0oBsG+NNKi10C2Guc0fT
	KS7l2ooupV5EjVzfRuuQHrP5RmmjwhDuRYdBa7jvQ0eFEva5g/ap5dfoZHnH5U0NF4WykMUdF3N
	gwEqK8fY2dM6nq+HW/Zzo9ZvKlPdT0+99bfuEIzVFSWqbEac2aLA26xZQ7/Umm/fwB3gkW5pfMJ
	QwOY/TJMT1+chLhHlN0iVKVVoV8b01xNtvTjlXA3ibranmpVUeeUTvJirg1JDBcBBIx/C6qc6zV
	/Qc8Onz1kWeReAfqlW/8knCMyDgf6N67KqjFzTIAfctNk8J68CHDgp5ZU2kNjq/kXKawXa04GTl
	I3+pS1iLQ6k0ci5KyGd+q3lEQzT9oSkoUQlXZFzQCfrNrgMczAiirmlugzx62MpPqSeY+5/QYy4
	yBbtvFwwx8pnGuvrnKM68qEeg+B+UlMW6NsezpB4lIP2WG6wTrpklKAqHjWstYVbDV6zAS+5sye
	KgqsgS6LM34REfarf2K6Dml9ZaAHPSSq+hwqzBop7AudDFhD5g+PQ4/YX/5S/mater8=
X-Received: by 2002:a05:690c:ee:b0:8b0:a957:80d4 with SMTP id 00721157ae682-8b2b66eccf9mr94941007b3.20.1793891401874;
        Thu, 05 Nov 2026 07:10:01 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bd35c7sm42380167b3.44.2026.11.05.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:10:00 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:19 +0000
Subject: [PATCH RFC v3 27/90] cells: add the "budget" slot
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
Message-Id: <20261105-b4-cells-v3-27-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=1542;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=oj66V8aCZSdgG20qiHDURXxVIGnAfze/B7P1AdO5Gf4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMHbZexBHDoBFDFcix8APhjU+THxpbH6b2eo97j4VDm4wo4tQlfr7N8B8fm8p1Ff5YjUvCMyPNo
 BsYrxSAj0lA8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

CELL_SET_FD with the key "budget" takes a file descriptor for a cgroup2
directory and makes that cgroup the budget of the cell.

Holding the cellfd gives authority over the cell, but not over the things
that are put into it. So cgroup_cell_budget_get() checks at this point
whether the caller may use the cgroup.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cell/slots.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/cell/slots.c b/kernel/cell/slots.c
index 905672db9936..3f74b4640334 100644
--- a/kernel/cell/slots.c
+++ b/kernel/cell/slots.c
@@ -31,6 +31,21 @@ static int cell_set_hostname(struct cell *cell, const char *val)
 	return 0;
 }
 
+/* A cgroup2 directory. Judged against whoever fills the slot, here and now. */
+static int cell_set_budget(struct cell *cell, struct file *file)
+{
+	struct cgroup *cgrp;
+
+	if (cell->budget)
+		return -EBUSY;
+	cgrp = cgroup_cell_budget_get(file, &cell->budget_uid, &cell->budget_gid);
+	if (IS_ERR(cgrp))
+		return PTR_ERR(cgrp);
+	cell->budget = cgrp;
+	cell->budget_id = cgroup_id(cgrp);
+	return 0;
+}
+
 static int cell_set_string(struct cell *cell, const char *key, const char *val)
 {
 	if (!strcmp(key, "hostname"))
@@ -46,6 +61,8 @@ static int cell_set_binary(struct cell *cell, const char *key,
 
 static int cell_set_fd(struct cell *cell, const char *key, struct file *file)
 {
+	if (!strcmp(key, "budget"))
+		return cell_set_budget(cell, file);
 	return -EINVAL;
 }
 

-- 
2.55.0

