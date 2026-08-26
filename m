Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7AB3E00B4;
	Wed, 26 Aug 2026 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741259; cv=none; b=tkx7DeZNMQEY4p5HQqswn9+JL1xI1e/BLlEpv+VDO7mWdI/O1JGpeUpo39O6lGBdxU3QWxUeEm/qglom7fEulFEmlXHQLOl9B+rLcAFqHT7wlI7pU/dXeEoWIepPr/NGwgvacNj8OmPFhBQopFbMKagN5ML1q4D08iGAnrMhL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741259; c=relaxed/simple;
	bh=S4DPjK3jIGGJ/C0gVoovxcEwKAcMxJB0rJtZf3g4pg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIPDkRdr1Jm14IeLpAtOjuwSrZ46WMiToUtIYWA/cH6pv97M9L5iqSJEwL3KSI2FmR9vrQfbgWSxBkW0SFUtKZYDP+oEc7ssPPOVtqWJ1TOCWouwsoWh//DC8g2dpEcZxvI+wBtZiFSguhjcjzMbnV1j1TzqCAZlLxNpKkW/kVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=I4kERVVZ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="I4kERVVZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=oqzejDd9vzId1IO7Db04ZVtuc3tXVUqp9W2Dq8YmPK0=; b=I4kERVVZVum4DGj61JyBeq5ZO/
	7/CwRtKmhB1zAUKbhpSIYIjzM0SFAzr9vtjwbbXSsnfs8t6gzsabKzxIspXE2kZWjUDPfG4qzv428
	QXJNVHy+NJxwwAYnh4NtGaOFYE6bFZrHrQqzo5z+gc5vo0Jr26IWNfAJ/36HPq4t2fnV48ZaK+3GT
	MzwYENT2HO6fVMIBijnPw1oK6JCUXmrKXtYwc8lTfrXJg5i+ZgI0Dbq6ZapyEiQc5P1tB5DFNTb2+
	ESCg0ZSAPIIRyDUv5uLN1UsrgzwR+dFup6o3Ej7ZAhJFgR1RyK8dCWx7wSTFUkXtSQX76TaZ7XwER
	JiAca2TQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzBAF-00FA0t-1J;
	Wed, 26 Aug 2026 10:47:27 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 26 Aug 2026 03:47:03 -0700
Subject: [PATCH 2/4] samples/configfs: add a subsystem that accepts
 symlinks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-config_selftest-v1-2-e364b07e91ac@debian.org>
References: <20260826-config_selftest-v1-0-e364b07e91ac@debian.org>
In-Reply-To: <20260826-config_selftest-v1-0-e364b07e91ac@debian.org>
To: Shuah Khan <shuah@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 gustavold@gmail.com, linux-fsdevel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 vasilisalmpanis@gmail.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=leitao@debian.org;
 h=from:subject:message-id; bh=S4DPjK3jIGGJ/C0gVoovxcEwKAcMxJB0rJtZf3g4pg4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqjsQz21/UyPcl87Dez5CZ5Vq/9C0bhiIGU4lTW
 ae9RjAKRHiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCao7EMwAKCRA1o5Of/Hh3
 baMlD/0Y8zdnerYGCGikoGok4UoH+bLY5YyUC8l45KaWmmrpKcdH0zBBDCvPf0DxFCOVidUJC7F
 3/hPtCPzpwF7p78Euptna3XZuhXoXmlbYcETEDtxcqGrzDxA0QkMgskTV1XynM3XG4p67HjIgA+
 9Yy4fColOj7r7f+d1YVSTAPeF3lyZH84zwoydU/jSVEYwCClujtpNLq30+w26ttRGW2lMl2a/cF
 9/aqJmwMcjWxUv7c9yo6JWuSCNuptPpODP26B2S6p/CZ9yzIKelgxgACob6iWEwirFYJKgbT8ug
 xH6zVxZT5Nv+WCne8/QV5fo4/7sllOjTk5qSDad0shjBF21HRxZMsC/Vx38IJnSPiIpqjnFqxk2
 vw7fAN5ai/QElZkS8MNKOdQnxtFXiDu4b6Y5x0RO3c/TvmySgyKfZdZoM+vVfHG6BYSPMybh5X0
 rxG2fXfBuzP6G3jESQuC5njY9fzlw89ZalmYiw+pE1PqT8etjKjXWKiZeKbJUh4TWQdMxos0KM/
 paycX3+j2zjJe/SkvSOKup/8YDiygcNlLhsuKmlwMkg8Zaxuk7JfySIIFf3bfNtWOdYmhh8qilZ
 Fd/YkPEPApszN3o1zNtuS04OPVYA6wWstdEHvXCcmu/0iyrU9e40kvus/Qe1Vb48iqO7fvKtHmO
 mUuP+Cys90lm8dg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The sample registers three subsystems and none implements ->allow_link(),
so the symlink(2) half of the configfs ABI has no small in-tree user to
test against.

Add 04-symlink-children, whose children take a link to any config_item and
export the number of links they hold.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 samples/configfs/configfs_sample.c | 121 +++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index c1b108ec4ea02..08403e787aef6 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -313,6 +313,126 @@ static struct configfs_subsystem group_children_subsys = {
 
 /* ----------------------------------------------------------------- */
 
+/*
+ * 04-symlink-children
+ *
+ * This example has children that are valid sources for symlink(2).  A
+ * child accepts a link to any other config_item and reports how many
+ * links it currently holds, so ->allow_link() and ->drop_link() are
+ * observable from userspace.
+ */
+
+struct symlink_child {
+	struct config_item item;
+	int nlinks;
+};
+
+static inline struct symlink_child *to_symlink_child(struct config_item *item)
+{
+	return container_of(item, struct symlink_child, item);
+}
+
+static ssize_t symlink_child_nlinks_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_symlink_child(item)->nlinks);
+}
+
+CONFIGFS_ATTR_RO(symlink_child_, nlinks);
+
+static struct configfs_attribute *symlink_child_attrs[] = {
+	&symlink_child_attr_nlinks,
+	NULL,
+};
+
+/*
+ * The VFS holds the source item's directory locked across symlink(2) and
+ * unlink(2), so ->nlinks needs no lock of its own.
+ */
+static int symlink_child_allow_link(struct config_item *src,
+		struct config_item *target)
+{
+	to_symlink_child(src)->nlinks++;
+
+	return 0;
+}
+
+static void symlink_child_drop_link(struct config_item *src,
+		struct config_item *target)
+{
+	to_symlink_child(src)->nlinks--;
+}
+
+static void symlink_child_release(struct config_item *item)
+{
+	kfree(to_symlink_child(item));
+}
+
+static const struct configfs_item_operations symlink_child_item_ops = {
+	.release	= symlink_child_release,
+	.allow_link	= symlink_child_allow_link,
+	.drop_link	= symlink_child_drop_link,
+};
+
+static const struct config_item_type symlink_child_type = {
+	.ct_item_ops	= &symlink_child_item_ops,
+	.ct_attrs	= symlink_child_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item *symlink_children_make_item(
+		struct config_group *group, const char *name)
+{
+	struct symlink_child *symlink_child;
+
+	symlink_child = kzalloc_obj(*symlink_child, GFP_KERNEL);
+	if (!symlink_child)
+		return ERR_PTR(-ENOMEM);
+
+	config_item_init_type_name(&symlink_child->item, name,
+				   &symlink_child_type);
+
+	return &symlink_child->item;
+}
+
+static ssize_t symlink_children_description_show(struct config_item *item,
+		char *page)
+{
+	return sprintf(page,
+"[04-symlink-children]\n"
+"\n"
+"This subsystem allows the creation of child config_items that\n"
+"symlink(2) can point at other config_items from.  Each child\n"
+"reports the number of links it holds.\n");
+}
+
+CONFIGFS_ATTR_RO(symlink_children_, description);
+
+static struct configfs_attribute *symlink_children_attrs[] = {
+	&symlink_children_attr_description,
+	NULL,
+};
+
+static const struct configfs_group_operations symlink_children_group_ops = {
+	.make_item	= symlink_children_make_item,
+};
+
+static const struct config_item_type symlink_children_type = {
+	.ct_group_ops	= &symlink_children_group_ops,
+	.ct_attrs	= symlink_children_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem symlink_children_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "04-symlink-children",
+			.ci_type = &symlink_children_type,
+		},
+	},
+};
+
+/* ----------------------------------------------------------------- */
+
 /*
  * We're now done with our subsystem definitions.
  * For convenience in this module, here's a list of them all.  It
@@ -324,6 +444,7 @@ static struct configfs_subsystem *example_subsys[] = {
 	&childless_subsys.subsys,
 	&simple_children_subsys,
 	&group_children_subsys,
+	&symlink_children_subsys,
 	NULL,
 };
 

-- 
2.53.0-Meta

