Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891654;
	b=og0xTo+0RiP2ip3ckCCn6Kn1fdBGodhX8bAiikgCWh9n6Z/eU1hEmuJP9o+33mdSfpCa
	 w3p7nnLupm0Hwtbo1hWkwG/BJnXn+AlFpWpNyloMOrm+CHes+p7df3K2epbVLA3UQXnPr
	 6mW9gPG89mwCbX+ZcUJz11ZHS8+JGRZkuHZJ+2rNYidRdXNFy7Wc59IM9W9XSzIK7KUZS
	 WbKGiY23lL/uWqTdFZ4T+3QW96/Ks5eBV5zSvscZ+r3KzgTeKQ+l4vTJc2WDp0tEArXLR
	 YQ5JsWKKDA2dsY+zVxamRlFA1b1HjNsZNRraHdYayNNToaNbOzxi0UBPIMHXa62IuuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=IXsQCDSdG7y1XG8+TdbE9NhcI3/PPLWdPr4Sx/VOURw=;
	b=29R/nljxFfWOEXr9WcpIFQTZFydA/s8/t0GRDKe2fFOhPKSZH4cLJYSp8NqaZeD2tKYq
	 OycnNq081RFFTQ4HStiqx8ZWaP8brg+0EnChd/TjvnrWgTgZGMT0T8aXna1mx13JScOO9
	 BqwHrhOy9k5IViZgDVadBMkK1PJExfFxYTAj3Cve29Hg/IPR5SCjgcHISdECgPNrr7DmN
	 7I3exQhP/fiNtvcD2VNI58OXBjFP+D6MNq3t72Bh07w/b3dCVylF0G18i0c3E6r+GWaiY
	 PdLBaqMu47eeSxYdHmt49at2pXzRfFb4M2WZMHeaUYcRNlVmPSUx2J0nxnhnoi+40hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=GIMLTF+E;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CCF606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4CCF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=GIMLTF+E
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53653e30353so26072571cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891653; x=1794496453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IXsQCDSdG7y1XG8+TdbE9NhcI3/PPLWdPr4Sx/VOURw=;
        b=GIMLTF+E4TlZ8ZiK5bXeSzeBywVYFjiBz2ltLqDas2nQ/k8Cn5SSw+bQGMdoRyXwme
         9cskKX+4g++7LogN3fVYiVhDsNX2NH2nYhpXNNa40so7uPc9PxgwKhYpAW9f26js3e9/
         wa7Zas3BgvvqRCZSt6R+pZvKCOPblTe3psDwQ/VVIaSWJ8amA/oAO5SqsO0sK170JRe4
         HPWurD2bM8zegiaLwvCvER1b67lXyv+ufYFVMRsUKz6Lp2TE5u6MTC9bYUsqXxeboobg
         zeFdRCofJ3f7zhmxwaKh0Rigfkyxg5+sWYk+zhQmboI8xn5ekzCCNPuY3e2d/DhGnM31
         JBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891653; x=1794496453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXsQCDSdG7y1XG8+TdbE9NhcI3/PPLWdPr4Sx/VOURw=;
        b=gPYg09yHC7AypMgRCbHc2xQr2ryCEiyFJOE1Yz5eRL8t0VGqLT3Jl/pxvEpJYsJeuh
         sQ4/JL4K3qQxHfBPOt7JngP/3XGpMylyIE/29Sbw9biRtuiFy7ItVcjuQOBkGCLy6Mnn
         nEWlOKTL8Z2iDHrIRCRUHIHEyFh/CVVXDAku1AOYmOwOZAzsf6/J1x8czw6kUIcIAQfF
         iw8E2Uj6KYwfa8U1ujUYwIARQaB53APacV1ltnbLGXW/+TfSQINA+IsGiZrnm+PlGoLr
         xQS0W0439J30snrpK45nEg27L8eJeugHR2CyoXyHWeCmtKbZxKUq82mHWhdlxFSLzbrt
         8vmg==
X-Gm-Message-State: APuU4Z+Q2yuZ5ufauyJr0qHQ3aifpOjc9uovm5grylSqgornO7tljRQ1
	c4VrnDiLu6qJ+jukMwLBTlEaIF5U65XIT5xMOHvj06jVc62wdYnTR5PLB3qXyZbivu4=
X-Gm-Gg: AYBFou34TeUW3w4xpomRzsrX72aCNnL/e2AkIYyznOvwO+OU0MBQRjM7OouGdD14AIU
	qdXDeLvpCScEslzRa6qk0gENOax9/movX/WO3+GtUJPcF1N3JqL/OJTbe8/9TyIl0uDpDYweyia
	3MpIlxFOPSvoNVmnmC2b+7baHdRyT1bipOzkGGuOBkAGd3MpM5uRR9c7U6VHpZ943Ca5gdlcY36
	6k/QqVJDul+9xGdVmj1tPGGM0+ON/KXlmXJak5EsKFy5bLK3T7sGj1fFLEtl+w4da3KLrdKTA08
	oaw/DCKHggH70kJANV84f7ZNB0iAX1XgEja3JuZy7NPBhzjiIEK2V08j1XkyDKlFLKvS7jS8cuo
	TPwmPmFD2X2M7KvXv1x9MeskKKBNaBMD4o0ZQBP9u0SCps7LyJiwE7UWcDRiMlCKzy4QS63PAe7
	fJZDpTcSbrchKXBTnIsL3mwM3NcH7xH9Si++68hPnX4XgbdMeZq89Vsys/jrZDUVHeGN0j3VCN3
	D/C8n9PFxKp/kQyQ33RjHbKBg49vbRZoEvlwTJEgWUqQTVu+oWTzuTmbnE/yXVeY0ebQGhSbVxm
	CjIhYQxvaSNX1T71Pt0Kl2zt5N5cDCpwvGB7W68yc2PcTA==
X-Received: by 2002:a05:622a:e08b:20b0:54b:6814:ffd5 with SMTP id d75a77b69052e-54b68151baamr62483211cf.48.1793891652813;
        Thu, 05 Nov 2026 07:14:12 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100ab908sm53756371cf.4.2026.11.05.07.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:14:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:30 +0000
Subject: [PATCH RFC v3 38/90] uprobes: cope with a new task that has no mm
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
Message-Id: <20261105-b4-cells-v3-38-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=944;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=asYZFy7hjqvikRZWFKWfSCfamB5AQy9/u+56vKzjgV4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGv6YniprB6w8Vm654PinKGYHdMJvsfa/Ng4Db0H8gcBHDq7Ki/rpw9PFMekPD325bHCG8UUOCz
 JiPvyE/o1kA4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

If the parent has pending return probes and the child does not share its
mm, uprobe_copy_process() copies the probes to the child and queues work
that sets up a probe area in the mm of the child.

A task that is created without an mm does not share the mm of its parent,
so it would take that path. It has no use for any of this. Return early
for such a task.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/events/uprobes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..af378f228d5c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2185,6 +2185,10 @@ void uprobe_copy_process(struct task_struct *t, u64 flags)
 
 	t->utask = NULL;
 
+	/* Nothing of the parent's mm matters to a task that has none. */
+	if (!t->mm)
+		return;
+
 	if (!utask || !utask->return_instances)
 		return;
 

-- 
2.55.0

