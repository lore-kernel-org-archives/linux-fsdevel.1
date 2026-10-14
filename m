Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425194AB1B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010895; cv=none; b=asLUMuhGHo7WdzBtN71vrb4urZ9PT24wNuHCqOLUgSheAWL+GPxgGuJCUMdSvRitXPoFFMwclC2Tn4UVbzsiLi7Vr5jZuYWoKU32sVfjPMtIUnNUx+VWKjfiRJtZtc9OiJCHFeOBvfqwijDBiiawpp2WHJJtoq/sMVxGzMofN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010895; c=relaxed/simple;
	bh=SURLLXVKbdJe4oh+rQN5mZZp8FsoWoJcWswVlOyrRPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ORgXLtSDfrFVTE5m2QhqD+yyx46Rs5R9HQWH8VO/UC5kPjE4KwzInDto0iCsXBaHvP9BelWQUuglgeWLlVGo/ABPZOenDhDXRb+a6FcNk+K45eFN0a4Z1jKXqaAJJAq9FdiZU4dSoevuX7hNvi9p+MmhrGkMGDxqi2sVK83IMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=iDHeo/Yb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="iDHeo/Yb"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91ba702cceaso9078946d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792010893; x=1792615693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6ZEVCcL2437a6X5ybbau3kMmqg+eTdm9EgDz7SIcRM=;
        b=iDHeo/YbMifHQOERWV+XZNFVtt501wHZH5NiP2rQgjDUsvt1SlzqfyiHuWMeuylhTb
         /Bd+75Tb5KMJ4Ou+xrTINZzYWJmF7jA5d8rzBmrjkDdsHiFibTvcQrapqpnZMFkCezN2
         dS/maMQHD06AEpIAKeR6GNMZwgpQYt5Cmx/hGSudZ//lb3o93qOUyS+M+37wYLZfrdtQ
         rfg3Ip8wBMJDTx4Uw/VBEv4SB7r11OrQO1jxwBGLslfDX7jh+dgDe44QmyhGc97vScnS
         DG7GajbYORL3MOSrtP4QI5dOwTI0+AC3l+W0o7VENR31db/VqpXfn4hXFlLF0TvUWTcp
         8Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010893; x=1792615693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6ZEVCcL2437a6X5ybbau3kMmqg+eTdm9EgDz7SIcRM=;
        b=gjVdHof96Dn6Hb0kmJsfNC0R4+8lL3Umg8Ssf9KaEmZsmqr/kBaFcKKsriQOsJIBIZ
         SpBMucH9PknHfWzbsqtOjDMuwS4AxyxTsLTnBiN5GomTNgpNQNoP8rsRVA7/bwmPi7Ed
         ralYXlSV2wNIdttvNPQ3J82q3hT+ewT5tlbr2ah4CN3q8VYiSwFHP0VsC+V8Ti4YHhxR
         fauVt0prF+WDJmB2N1aalOp5Yi6AlmCDqqiyqHprXXKaXl+eAOBimrHGbje5slljbVCg
         3YZ/17zBlta7FjU/z5ie4kQ7E66CDQtljTYn6ndT8KtpUTfX2CX5u9Yrruu4u84TmcAX
         lJ5g==
X-Forwarded-Encrypted: i=1; AKwUvBwPNF5bWLzvASQUXy4X5Popl4AELZrmjBHWoOs7zF2a9j627V6e/U9EPtzXxFDHBIuI+lMiK94MDvfoutO1@vger.kernel.org
X-Gm-Message-State: AFq9FYK+YPy6Cvkp27T3WWtMr18mB5KAqSi2x9KpoMAzqKV5lhg+TJac
	PGi5CiBnrsTnkNIwfYX9TeLJDm/j73zuc+p6SpHQ9y2Jdg2KWDAdIL1kIQTYfwnlgXU=
X-Gm-Gg: AYBFou2TNFKnFIGwZapJ+iC+rRlZwrGfFl6vBN+E+xq1uphNXs39kqzyCSaBCZyt5xK
	rlBwgjWcPKTZUo346m/xvJCx28ROYIDy7Zi0/Q1SNs4YQtdXdRyqQDKw5UDqYRXtmQnT7l4FMQa
	4GB5iePuYv0/ULFPAak4dvPGZgwhPSARqiENhHPFf+8I47/vxlUum5LrhhEGAsAlX6iZD+9cC5V
	8Xfxb37msyuSyxLbUgxoXDYAZfM/0n2PMbFjOo4ieQ9CI7/S9yxbgVzGXH65G5T9Rv9XlpSPDG8
	uWjF7TZkhtQdYbUszuuZxhWJ87IfzsEb2XKbVyJhlyGli5YxYlzdiiHWuNu8qzMx4a+CQtJdM68
	1RLFY2M6VKSYRzS0rJGhuwl/oWyz0lXNleI029ERlWxKKNUCUGl7+INE+/4z8bOye7fS4KksQJ0
	Pg+uvtZ2S56mD4Ry3hWjARlo7XACqRH5gPWpUWPAxEYElSszJA0pu5N2jY4aBRx9iadSzNPmctT
	abjImxTBdDHO1cwfo/4Yv7OgEI=
X-Received: by 2002:a05:620a:171e:b0:93b:d7a3:45d0 with SMTP id af79cd13be357-93ebd293de6mr2563371285a.57.1792010892437;
        Wed, 14 Oct 2026 13:48:12 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5028051sm582408385a.18.2026.10.14.13.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:48:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 14 Oct 2026 20:47:47 +0000
Subject: [PATCH v2 2/5] userns: don't let setns() lend CAP_SETFCAP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-setfcap-userns-v2-2-fac4d19281d7@toxicpanda.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
In-Reply-To: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792010880; l=2699;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=SURLLXVKbdJe4oh+rQN5mZZp8FsoWoJcWswVlOyrRPg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCAe4dSbXbzqRr9RUIjQ/O/Vty7mTOCY6bKiZblvqs4grh9LSM730NY/0mu92ENvCx96B/KrSLf
 2BGxLu2NhaQg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
because a task in such a namespace can write file capabilities that are
honoured in the parent.  A task that is already in the namespace has a
full capability set there and can't be asked any more, so
verify_root_map() goes by what the creator had, now ns->setfcap_level.

But setns() lets other tasks in, and they get the full set as well:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      ns->setfcap_level is A's -> allowed

or, if A's namespace maps uid 0 already, B sets security.capability on a
file.  Either way B ends up with file capabilities that are honoured in
the initial namespace, which it could not have written there, nor in a
namespace it created itself.

Refuse setns() into a user namespace unless the joiner's CAP_SETFCAP
reaches at least as far up as the namespace's setfcap_level.  Then every
task in a namespace is entitled to what its setfcap_level says, and the
checks on the way to file capabilities can go by the namespace.  This
has to apply to every user namespace, also to those that don't map the
parent's uid 0: through an idmapped mount, a root user that only exists
in the namespace can be stored as the parent's.

The change in behaviour is that a task without CAP_SETFCAP gets -EPERM
when it tries to setns() into a user namespace created by a task that
had it, such as a root-created container.  Tasks with CAP_SETFCAP, and
unprivileged users joining their own namespaces, are not affected.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index a5a94367600d..330085a7d7d4 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,13 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Everybody in the namespace gets CAP_SETFCAP that reaches as far up
+	 * as its setfcap_level, so only let in tasks whose own reaches as far.
+	 */
+	if (cap_setfcap_level(current_cred(), user_ns->parent) >
+	    user_ns->setfcap_level)
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;

-- 
2.55.0

